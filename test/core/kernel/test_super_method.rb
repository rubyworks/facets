covers 'facets/kernel/super_method'

test_case Kernel do

  method :super_method do

    setup "class heirarchy" do
      @x = Class.new{ def x ; 1 ; end }
      @y = Class.new(@x){ def x ; 2 ; end }
      @z = Class.new(@y){ def x ; 3 ; end }
    end

    test do
      x = @x.new
      z = @z.new
      s0 = x.method(:x)
      s1 = z.super_method(@x, :x)
      s1.call.assert == s0.call
    end

  end

end
