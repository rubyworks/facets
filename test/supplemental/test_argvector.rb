covers 'facets/argvector'

tests Argvector do

  unit :parameters do
    line = "-x baz --foo=8 bar"
    cargs = Argvector.new(line)
    args, keys = cargs.parameters
    args.assert == ['baz','bar']
    keys.assert == {'foo'=>'8','x'=>true}
  end

  unit :parameters => "with arity" do
    line = "-g a -x b -x c"
    cargs = Argvector.new(line, :g=>1, :x=>1)
    args, keys = cargs.parameters
    keys.assert == {'g'=>'a','x'=>['b','c']}
    args.assert == []
  end

  unit :parameters => "repeated option" do
    line = "-x baz --foo=1 --foo=2 bar"
    cargs = Argvector.new(line)
    args, keys = cargs.parameters
    args.assert == ['baz','bar']
    keys.assert == {'x'=>true,'foo'=>['1','2']}
  end

  unit :parameters do
    line = "-q baz --aq 5 bar"
    cargs = Argvector.new(line,'aq'=>1)
    words, flags = cargs.parameters
    words.assert == ['baz','bar']
    flags.assert == {'q'=>true,'aq'=>'5'}
  end

  unit :preoptions do
    line = "-x --foo=7 baz -y bar"
    cargs = Argvector.new(line)
    flags = cargs.preoptions
    flags.assert == {'x'=>true,'foo'=>'7'}
  end

  unit :flags do
    line = "-x baz --foo=8 bar"
    cargs = Argvector.new(line)
    flags = cargs.flags
    flags.assert == ['x']
  end

end

