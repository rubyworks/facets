covers 'facets/argvector'

test_case Argvector do

  method :parameters do

    test do
      line = "-x baz --foo=8 bar"
      cargs = Argvector.new(line)
      args, keys = cargs.parameters
      args.assert == ['baz','bar']
      keys.assert == {'foo'=>'8','x'=>true}
    end

    test "with arity" do
      line = "-g a -x b -x c"
      cargs = Argvector.new(line, :g=>1, :x=>1)
      args, keys = cargs.parameters
      keys.assert == {'g'=>'a','x'=>['b','c']}
      args.assert == []
    end

    test "repeated option" do
      line = "-x baz --foo=1 --foo=2 bar"
      cargs = Argvector.new(line)
      args, keys = cargs.parameters
      args.assert == ['baz','bar']
      keys.assert == {'x'=>true,'foo'=>['1','2']}
    end

    test do
      line = "-q baz --aq 5 bar"
      cargs = Argvector.new(line,'aq'=>1)
      words, flags = cargs.parameters
      words.assert == ['baz','bar']
      flags.assert == {'q'=>true,'aq'=>'5'}
    end

  end

  method :preoptions do

    test do
      line = "-x --foo=7 baz -y bar"
      cargs = Argvector.new(line)
      flags = cargs.preoptions
      flags.assert == {'x'=>true,'foo'=>'7'}
    end

  end

  method :flags do

    test do
      line = "-x baz --foo=8 bar"
      cargs = Argvector.new(line)
      flags = cargs.flags
      flags.assert == ['x']
    end

  end

end

