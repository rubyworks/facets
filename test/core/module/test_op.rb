covers 'facets/module/op.rb'

testcase Module do

  a = Module.new do
    def x; "x"; end
    def z; "zA"; end
  end

  b = Module.new do
    def y; "y"; end
    def z; "zB"; end
  end

  unit :+ do
    q = a + b
    q.extend q

    q.x.assert == "x"
    q.y.assert == "y"
    q.z.assert == "zB"
  end

  unit :- do
    r = a - b
    r.extend r

    r.x.assert == "x"
    NoMethodError.assert.raised?{ r.z }
  end

  unit :* do
    z = a * { :x => :y }
    z.extend z

    z.y.assert == "x"
    z.z.assert == "zA"
    NoMethodError.assert.raised?{ z.x }
  end

end

