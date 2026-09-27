covers 'facets/module/alias_module_function'

test_case Module do

  method :alias_module_function do

    test do
      m = Module.new do
        def x ; 33 ; end

        module_function :x

        alias_module_function :y, :x
      end

      m.y.assert == 33
      m.private_method_defined?(:y).assert == true
    end

    test "alias stays public when aliased again" do
      m = Module.new do
        module_function
        def x ; 33 ; end
        alias_module_function :y, :x
      end

      m.singleton_class.send(:alias_method, :z, :y)
      m.z.assert == 33
    end

  end

end
