covers 'facets/module/instance_method_defined'

test_case Module do

  method :instance_method_defined? do

    test do
      c = Class.new do
        def x; "x"; end
      end
      c.assert.instance_method_defined?(:x)
    end

  end

  method :singleton_method_defined? do

    test do
      c = Class.new do
        def self.x; "x"; end
      end
      c.assert.singleton_method_defined?(:x)
    end

  end

  method :module_method_defined? do

    test "alias for #singleton_method_defined" do
      c = Class.new do
        def self.x; "x"; end
      end
      c.assert.module_method_defined?(:x)
    end

  end

end
