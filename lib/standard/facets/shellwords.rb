require 'shellwords'

module Shellwords

  module_function

  # Escape special characters used in most unix shells
  # to use it, eg. with system().
  #
  # This differs from Ruby's #escape in that it does not
  # escape shell variables, e.g. $0.
  def alt_escape(cmdline)
    cmdline.gsub(/([\\\t\| &`<>)('"])/) { |s| '\\' << s }
  end

  unless method_defined?(:escape)
    def escape(cmdline)
      cmdline.gsub(/([\\\t\| &`<>)('"])\$/) { |s| '\\' << s }
    end
  end

  # Escape special character used in DOS-based shells.
  #
  # TODO: How to integrate with rest of system?
  # 1. Use platform condition?
  # 2. Use separate dos_xxx methods?
  # 3. Put in separate PowerShellwords module?
  #
  # CREDIT: Lavir the Whiolet
  def dos_escape(cmdline)
    '"' + cmdline.gsub(/\\(?=\\*\")/, "\\\\\\").gsub(/\"/, "\\\"").gsub(/\\$/, "\\\\\\").gsub("%", "%%") + '"'
  end

  # The coolest little arguments parser in all of Rubyland.
  #
  # CREDIT: Michel Martens
  def parse(argv, opts)
    argv = (String === argv ? shellwords(argv) : argv.to_a.dup)
    args = []
    while argv.any?
      item = argv.shift
      flag = opts[item]
      if flag
        # Work around lambda semantics in 1.8.7.
        arity = [flag.arity, 0].max
        # Raise if there are not enough parameters
        # available for the flag.
        if argv.size < arity
          raise ArgumentError
        end
        # Call the lambda with N items from argv,
        # where N is the lambda's arity.
        flag.call(*argv.shift(arity))
      else
        # Collect the items that don't correspond to
        # flags.
        args << item
      end
    end
    args
  end

  # Original name for Shellwords#parse.
  alias_method :run, :parse

end

class Array

  # Convert an array into command line parameters.
  # The array is accepted in the format of Ruby
  # method arguments --ie. [arg1, arg2, ..., hash]
  #
  def shellwords
    opts, args = *flatten.partition{ |e| Hash === e }
    opts = opts.inject({}){ |m,h| m.update(h); m }
    opts.shellwords + args
  end

  #
  def shelljoin
    Shellwords.shelljoin(shellwords)
  end

end

class Hash

  #
  def shellwords
    argv = []
    each do |f,v|
      m = f.to_s.size == 1 ? '-' : '--'
      case v
      when false, nil
      when Array
        v.each do |e|
          argv << %[#{m}#{f}="#{e}"]
        end
      when true
        argv << %[#{m}#{f}]
      else
        argv << %[#{m}#{f}="#{v}"]
      end
    end
    argv
  end

  #
  def shelljoin
    shellwords.shelljoin
  end

end

