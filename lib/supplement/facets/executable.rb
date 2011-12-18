# = Executable Mixin
#
# The Executable mixin is a very quick and and easy way to make almost
# any class usable via a command line interface. It simply uses writer
# methods as option setters, and the first command line argument as a
# method to call with the subsequent arguments passed to the method.
#
# The only limitation of this approach is that non-boolean options must
# be specified with `key=value` notation.
#
#   class Example
#     include Executable
#
#     attr_accessor :quiet
#
#     def bread(*args)
#       ["bread", quiet, *args]
#     end
#
#     def butter(*args)
#       ["butter", quiet, *args]
#     end
#   end
#
#   ex = Example.new
#
#   ex.execute!("butter yum")
#   => ["butter", nil, "yum"]
#
#   ex.execute!("bread --quiet")
#   => ["butter", true]
#
# Executable also provides #option_missing, which you can overriden to provide
# suitable results when a given command line option has no corresponding 
# writer method.
#
module Executable

  # Used the #excute! method to invoke the command.
  def execute!(argv=ARGV)
    Executable.execute(self, argv)
  end

  ## When no attribute write exists for an option that has been given on
  ## the command line #option_missing is called. Override #option_missing
  ## to handle these cases, if needed. Otherwise a NoMethodArgument will be
  ## raised. This callback method receives the name and value of the option.
  #def option_missing(opt, arg)
  #  raise NoMethodError, "undefined option `#{opt}=' for #{self}"
  #end

  class << self

    # Process the arguments as an exectuable against the given object.
    def execute(obj, argv=ARGV)
      args   = parse(obj, argv)
      subcmd = args.first
      if subcmd && !obj.respond_to?("#{subcmd}=")
        obj.send(*args)
      else
        obj.method_missing(*args)
      end
    end

    # The original name for #execute.
    alias_method :run, :execute

    # Parse command line with respect to +obj+.
    def parse(obj, argv)
      case argv
      when String
        require 'shellwords'
        argv = Shellwords.shellwords(argv)
      else
        argv = argv.dup
      end

      argv = argv.dup
      args, opts, i = [], {}, 0
      while argv.size > 0
        case opt = argv.shift
        when /=/
          parse_equal(obj, opt, argv)
        when /^--/
          parse_option(obj, opt, argv)
        when /^-/
          parse_flags(obj, opt, argv)
        else
          args << opt
        end
      end
      return args
    end

    # Parse a setting option.
    def parse_equal(obj, opt, argv)
      if md = /^[-]*(.*?)=(.*?)$/.match(opt)
        x, v = md[1], md[2]
      else
        raise ArgumentError, "#{x}"
      end
      # TODO: to_b if 'true' or 'false' ?
      #if obj.respond_to?("#{x}=")
        obj.send("#{x}=", v)
      #else
      #  obj.option_missing(x, v)
      #end
    end

    # Parse a named boolean option.
    def parse_option(obj, opt, argv)
      x = opt.sub(/^--/, '')
      #if obj.respond_to?("#{x}=")
        obj.send("#{x}=", true)
      #else
      #  obj.option_missing(x, true)
      #end
    end

    # Parse flags. Each character of a flag set is treated as a separate option.
    # For example:
    #
    #   $ foo -abc
    #
    # Would be parsed the same as:
    #
    #   $ foo -a -b -c
    #
    def parse_flags(obj, opt, args)
      x = opt.sub(/^-/, '')
      #c = 0
      x.split(//).each do |k|
        #if obj.respond_to?("#{k}=")
          obj.send("#{k}=", true)
        #else
        #  obj.option_missing(x, true)
        #end
      end
    end

  end #class << self

  # Optional support for implicit flags.
  #
  # TODO: implement Flags mixin
  module Flags  

  end #module Flags

  # Optional help mixin.
  #
  module Help

    def self.included(base)
      base.extend Domain
      super(base)
    end

    # Class-level domain.
    module Domain
      #
      def help(text=nil)
        return(@help ||= {}) unless text
        singleton_class = (class << self; self; end)
        singleton_class.class_eval do
          define_method(:method_added) do |name|
            @help ||= {}
            @help[name] = text
            singleton_class.send(:remove_method, :method_added)
          end
        end
      end
    end

  end #module Help

end #module Executable
