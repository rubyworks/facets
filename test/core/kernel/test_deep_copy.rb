covers 'facets/kernel/deep_copy'

test_case Kernel do

  method :deep_copy do

    test do
      o = "This is a week test."
      d = o.deep_copy
      d.assert == "This is a week test."
    end

  end

  method :deep_clone do

    setup "a class with reference to another class" do
      xC = Class.new do
        attr_reader :x
        def initialize
          @x = 1
        end
      end

      @c = Class.new do
        attr_reader :y
        define_method(:initialize) do
          @y = xC.new
        end
      end
    end

    test do
      o = @c.new
      d = o.deep_clone
      d.y.x.assert == 1
    end

  end

end
