covers 'facets/kernel/meta_class'

tests Kernel do

  unit :meta_class do
    x = Class.new
    m = (class << x; self; end)
    x.meta_class.assert == m
  end

  unit :metaclass => "non-underscored alias" do
    x = Class.new
    m = (class << x; self; end)
    x.metaclass.assert == m
  end

  unit :meta_class => "class_eval block on meta class" do
    c = Class.new
    c.meta_class do
      def foo; "foo"; end
    end
    c.foo.assert == "foo"
  end

end
