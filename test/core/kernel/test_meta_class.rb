covers 'facets/kernel/meta_class'

tests Kernel do

  unit :meta_class do
    x = Class.new
    m = (class << x; self; end)
    x.meta_class.assert == m
  end

  unit :meta_class => "with block" do
    c = Class.new
    c.metaclass do
      def x; "x"; end
    end
    c.x.assert == "x"    
  end

  unit :metaclass do
    x = Class.new
    m = (class << x; self; end)
    x.metaclass.assert == m
  end

end
