# = ArgVector
#
# == Synopsis
#
# ArgVector provides a very simple means of parsing
# command line arguments.
#
# Unlike other more complex libs this provides only
# the most basic and standard parsing functionality.
# In many cases that's all one really needs.
#
# Usage is straight foward. Simply instantiate the
# class and query it for the particular "views" of
# the command line you want.
#
#   cargs = ArgVector.new("-a foo -b=2")
#
#   cargs.parameters    #=> [['foo'],{'a'=>true,'b'=>'2'}]
#   cargs.flags         #=> ['a']
#   cargs.preoptions    #=> {'a'=>true}
#   cargs.preflags      #=> ['a']
#   cargs.subcommand    #=> ['foo', [], {'b'=>'2'}]
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or
# redistribute this software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.

require 'shellwords'

# = Argvector
#
# Argvector provides a very simple means of parsing
# command line arguments.
#
# Unlike other more complex libs this provides only
# the most basic and standard parsing functionality.
# In many cases that's all one really needs.
#
# Usage is straight foward. Simply instantiate the
# class and query it for the particular "views" of
# the command line you want.
#
#   cargs = Argvector.new("-a foo -b=2")
#
#   cargs.parameters    #=> [['foo'],{'a'=>true,'b'=>'2'}]
#   cargs.flags         #=> ['a']
#   cargs.preoptions    #=> {'a'=>true}
#   cargs.preflags      #=> ['a']
#   cargs.subcommand    #=> ['foo', [], {'b'=>'2'}]
#
class Argvector

  def self.parameters(*args)
    new.parameters(*args)
  end

  attr :line
  attr :argv
  attr :arity
  ##attr :opts

  ##alias :flags :options

  # Takes the command line string (or array) and options.
  # Options have flags and end with a hash of option arity.
  #
  def initialize(line=nil, arity=nil)
    @line, @argv  = parse_line(line)
    @arity = parse_arity(arity||{})
    parse
  end

  public

  # Returns operand array.
  def operands
    @operands
  end
  
  # deprecate alias ?
  alias arguments operands

  # Returns options hash.
  def options
    @options
  end

  # Returns [operands, options], which is good for plugging
  # directly into a method.
  def parameters
    return @operands, @options
  end

  # Return flags, which are true options.
  def flags
    f = []
    @options.each do |k, v|
      if TrueClass===v or FalseClass===v  # not that it's ever false
        f << k
      end
    end
    return f
  end

  # Assumes the first operand is a "subcommand" and
  # returns it and the argments following it as
  # parameters.
  def subcommand_with_parameters
    opts, args = *parse_preoptions(argv)
    cmd = args.shift
    subargs = self.class.new(args, @arity)
    return [cmd, *subargs.parameters]
  end

  alias subcommand subcommand_with_parameters

  #
  def subcommand_with_preoptions
    pre, args = *parse_preoptions(argv)
    cmd = args.shift
    subargs = self.class.new(args, @arity)
    args, opts = *subargs.parameters
    return [cmd, args, pre.merge(opts)]
  end

  # Assumes the first operand is a "subcommand" and
  # returns it and the argments following it as
  # another Arguments object.
  #
  # TODO: This probably should be called 'subcommand'.
  #
  def subcommand_with_arguments
    opts, args = *parse_preoptions(argv)
    cmd = args.shift
    subargs = self.class.new(args, @arity)
    return cmd, subargs
  end

  # Returns a hash of options that occur before
  # the first operand. This works well with
  # subcommand to get the main command's options.
  #
  #   line = "--trace stamp --file VERSION"
  #   cargs = Argvector.new(line)
  #   opts = cargs.preoptions
  #   opts #=> {"trace"=>true}
  #
  def preoptions
    preopts, remainder = *parse_preoptions(argv)
    return preopts
  end

  # Same as +flags+ but only returns flags in the
  # preoptions.
  def preflags
    preopts, remainder = *parse_preoptions(argv)
    f = []
    preopts.each do |k, v|
      if TrueClass===v or FalseClass===v  # not that it's ever false
        f << k
      end
    end
    return f
  end

  # Like parameters but without allowing for duplicate options.
  def parameters_without_duplicates
    opts = {}
    @options.each do |k,v|
      if Array===v
        opts[k] = v[0]
      else
        opts[k] =  v
      end
    end
    return @operands, opts
  end

  #private

  # Basic parser partitions the command line into options and
  # operands. Options are converted to a hash and the two 
  # parts are returned.
  #
  #   line = "--trace stamp --file=VERSION"
  #   argv = Argvector.new(line)
  #
  #   args, keys = *argv.parse
  #
  #   args #=> ["stamp"]
  #   keys #=> {"trace"=>true, "file"=>"VERSION"}
  #
  def parse
    args = assoc_options(argv) #, *opts_arity)

    opts, opds = args.partition{ |a| Array === a }

    @operands = opds
    @options  = format_options(opts)

    return @operands, @options
  end

  # First pass parser to split the command line into an
  # array using Shellwords, if not already so divided.
  def parse_line(line=nil)
    if line
      case line
      when String
        argv = Shellwords.shellwords(line)
      else
        argv = line.to_ary.dup
        line = argv.join(' ')
      end
    else
      argv = ARGV.dup
      line = argv.join(' ')
    end
    return line, argv
  end

  ## Ensure opts are a uniform.
  ##
  ##def clean_opts( opts )
  ##  opts2 = opts.collect{ |o| o.to_sym }
  ##  opts2 = opts2 & [:simple, :repeat]  # valid options only
  ##  return opts2
  ##end

  # Ensure arity is uniform.
  def parse_arity(arity)
    arity2 = {}
    arity.each{ |k,v| arity2[k.to_s] = v.to_i }
    return arity2
  end

  # Parse preoptions. A "preoption" is one that
  # occurs before the first operans (if any).
  def parse_preoptions(args)
    ##args = args.dup
    args = multi_flag(args) #unless opts.include?(:simple)

    flags = []
    while args.first =~ /^-/
      key = args.shift
      key.sub!(/^-{1,2}/,'')
      if key.index('=')
        key, val = key.split('=')
      elsif a = arity[key]
        val = args.slice!(0,a)
        val = val.first if a == 1
      else
        val = true
      end
      flags << [key, val]
    end

    flags = format_options(flags)

    return flags, args
  end

  # Parse flags takes the command line and transforms it such that
  # flags (eg. -x and --x) are elemental associative arrays.
  #
  #   line = "--foo hello --try=this"
  #   argv = Argvector.new(line)
  #
  #   args = line.split(/\s/)
  #   argv.assoc_options(args)  #=> [ ["foo",true], "hello", ["try","this"] ]
  #
  def assoc_options(args)
    ##args = args.dup
    args = multi_flag(args) #unless opts.include?(:simple)
    i = 0
    while i < args.size
      arg = args[i]
      case arg
      when /^-/
        arg = arg.sub(/^-{1,2}/,'')
        if arg.index('=')
          key, val = arg.split('=')
          args[i] = [key, val||true]
        elsif arity.key?(arg)
          cnt = arity[arg]
          key = arg
          val = args[i+1,cnt]
          args[i,cnt+1] = [[key, *val]]
          i += (cnt - 1)
        else
          key = arg
          args[i] = [key,true]
        end
      end
      i += 1
    end
    return args
  end

  # Split single letter option groupings into separate options.
  # ie. -xyz => -x -y -z
  def multi_flag(args=nil)
    args ||= argv
    args.collect { |arg|
      if md = /^-(\w{2,})/.match( arg )
        md[1].split(//).collect { |c| "-#{c}" }
      else
        arg.dup
      end
    }.flatten
  end

  # Format flag options. This converts the associative array of
  # options/flags into a hash. Repeat options will be placed in arrays.
  def format_options(assoc_options)
    opts = {}
    assoc_options.each do |k,v|
      if opts.key?(k)
        opts[k] = [opts[k]].flatten << v
      else
        opts[k] = v
      end
    end
    return opts
  end

end

ArgVector = Argvector
