covers 'facets/kernel/super_method'

tests Kernel do

  context "class heirarchy" do
    q1 = Class.new{ def x ; 1 ; end }
    q2 = Class.new(q1){ def x ; 2 ; end }
    q3 = Class.new(q2){ def x ; 3 ; end }
    [q1, q2, q3]
  end

  unit :super_method do |q|
    x = q[0].new
    z = q[2].new
    s0 = x.method(:x)
    s1 = z.super_method(q[0], :x)
    s1.call.assert == s0.call
  end

end
