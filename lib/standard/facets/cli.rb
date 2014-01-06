module Kernel
  private
  #
  # CLI is based on Clap library
  # Copyright (c) 2010 Michel Martens
  #
  def cli(*args)
    opts = args.pop
    argv = (args.first || ARGV).dup
    args = []

    # Split option aliases.
    opts = opts.inject({}) do |h,(k,v)|
      k.to_s.split(/\s+/).each{|o| h[o]=v}; h
    end

    # Convert single dash flags into multiple flags.
    argv = argv.inject([]) do |a, v|
      if v[0,1] == '-' && v[1,1] != '-'
        a.concat(v[1..-1].chars.map{|c| "-#{c}"})
      else
        a << v
      end
      a
    end

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
end
