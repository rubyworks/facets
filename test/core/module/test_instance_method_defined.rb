covers 'facets/module/instance_method_defined'

tests Module do

  unit :instance_method_defined? do
    c = Class.new do
      def x; "x"; end
    end
    c.assert.instance_method_defined?(:x)
  end

  unit :singleton_method_defined? do
    c = Class.new do
      def self.x; "x"; end
    end
    c.assert.singleton_method_defined?(:x)
  end

  unit :module_method_defined? => "alias for #singleton_method_defined" do
    c = Class.new do
      def self.x; "x"; end
    end
    c.assert.module_method_defined?(:x)
  end

end
