require 'shellwords'

module Shellwords

  module_function

  # Escape backslash, tab, space, and the characters | & ` < > ( ) ' "
  # with a backslash.
  #
  # Unlike Ruby's Shellwords.escape, this leaves other shell
  # metacharacters alone, including $ (so shell variables still
  # expand), ; * ? ~ and newlines. It is not safe for untrusted
  # input: use Shellwords.escape for that.
  def alt_escape(cmdline)
    cmdline.gsub(/([\\\t\| &`<>)('"])/) { |s| '\\' << s }
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
  #   ['a', 'b', {d: true}].shellwords  #=> ["-d", "a", "b"]
  #
  # To make a command line of them, join them with Ruby's Array#shelljoin:
  #
  #   ['a', 'b', {d: true}].shellwords.shelljoin  #=> "-d a b"
  #
  def shellwords
    opts, args = *flatten.partition{ |e| Hash === e }
    opts = opts.inject({}){ |m,h| m.update(h); m }
    opts.shellwords + args
  end

end

module Facets

  # Facets' Array#shelljoin used to convert the array with #shellwords first,
  # which changed Ruby's own Array#shelljoin: nested arrays were flattened
  # and hashes became options, so structured input, such as a web request's
  # parameters, could add arguments to a command. Ruby's version escapes
  # each element as one argument. Facets now leaves it alone, and only
  # warns when the old Facets version would have given a different result.
  #
  # @deprecated Scheduled for removal after 2027-09-30.
  module ArrayShelljoin
    def shelljoin
      if any? { |e| Hash === e || Array === e }
        warn "Facets' Array#shelljoin is deprecated. Array#shelljoin now escapes each element, " \
             "as Ruby's own does, so hashes and nested arrays are no longer turned into options. " \
             "To get those, use array.shellwords.shelljoin. It will be removed after 2027-09-30.", uplevel: 1
      end
      super
    end
  end

end

Array.prepend(Facets::ArrayShelljoin)

class Hash

  # Convert a hash into command line flags, one word per flag.
  #
  #   {debug: true, name: 'jim', v: true}.shellwords
  #   #=> ["--debug", "--name=jim", "-v"]
  #
  # A one-letter key gives a short flag (`-v`) and a longer key a long one
  # (`--debug`). A value of `true` gives the bare flag, and `false` or `nil`
  # leaves the flag out. An array value repeats the flag for each element.
  # Any other value is joined to the flag with `=`.
  #
  #   {I: ['lib', 'test'], quiet: false}.shellwords
  #   #=> ["-I=lib", "-I=test"]
  #
  # Each flag and its value is one word, unquoted, ready to pass to
  # `system(*words)` or to join with Ruby's Array#shelljoin, which escapes
  # what the shell needs.
  #
  #   {name: 'a b'}.shellwords.shelljoin  #=> "--name\\=a\\ b"
  #
  def shellwords
    argv = []
    each do |f,v|
      m = f.to_s.size == 1 ? '-' : '--'
      case v
      when false, nil
      when Array
        v.each do |e|
          argv << "#{m}#{f}=#{e}"
        end
      when true
        argv << "#{m}#{f}"
      else
        argv << "#{m}#{f}=#{v}"
      end
    end
    argv
  end

  # Convert a hash into command line flags, escaped and joined into one
  # string. See Hash#shellwords.
  #
  #   {debug: true, name: 'jim'}.shelljoin  #=> "--debug --name\\=jim"
  #
  def shelljoin
    shellwords.shelljoin
  end

end

