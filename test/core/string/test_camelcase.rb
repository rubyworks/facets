covers 'facets/string/camelcase'

test_case String do

  method :camelcase do

    test do
      "Camel_case".camelcase.assert == "CamelCase"
    end

    test "converts underscore to captialized" do
      "abc_xyz".camelcase.assert == "AbcXyz"
      "abc____xyz".camelcase.assert == "AbcXyz"
    end

    #test "converts spaces to captialized" do
    #  "abc xyz".camelcase.assert  == "AbcXyz"
    #  "abc  xyz".camelcase.assert == "AbcXyz"
    #  "abc\txyz".camelcase.assert == "AbcXyz"
    #  "abc\nxyz".camelcase.assert == "AbcXyz"
    #end

    test "true argument converts first letter to lowercase" do
      "abc_xyz".camelcase(true).assert == "abcXyz"
      "abc____xyz".camelcase(true).assert == "abcXyz"
    end

    test "false argument leaves first letter as is" do
      "abc_xyz".camelcase(false).assert == "abcXyz"
      "abc____xyz".camelcase(false).assert == "abcXyz"
      "Abc_xyz".camelcase(false).assert == "AbcXyz"
      "Abc____xyz".camelcase(false).assert == "AbcXyz"
    end

    #test "false converts spaces to captialized" do
    #  "abc xyz".camelcase(false).assert == "abcXyz"
    #  "abc  xyz".camelcase(false).assert == "abcXyz"
    #  "abc\txyz".camelcase(false).assert == "abcXyz"
    #  "abc\nxyz".camelcase(false).assert == "abcXyz"
    #end

    test "converts paths to module names" do
      'this_is_it'.camelcase.assert == 'ThisIsIt'
      'my_module/my_class'.camelcase.assert == 'MyModule::MyClass'
      '/my_module/my_class'.camelcase.assert == '::MyModule::MyClass'
    end

    #test "converts methods to module names" do
    #  'my_module__my_class'.camelcase.assert == 'MyModule::MyClass'
    #  '__my_module__my_class'.camelcase.assert == '::MyModule::MyClass'
    #end

  end

  method :lower_camelcase do
    test do
      "abc_xyz".lower_camelcase.assert == "abcXyz"
      "Abc_xyz".lower_camelcase.assert == "abcXyz"
    end
  end

  method :upper_camelcase do
    test do
      "abc_xyz".upper_camelcase.assert == "AbcXyz"
      "Abc_xyz".upper_camelcase.assert == "AbcXyz"
    end
  end

  method :inter_camelcase do
    test do
      "abc_xyz".inter_camelcase.assert == "abcXyz"
      "Abc_xyz".inter_camelcase.assert == "AbcXyz"
    end
  end

end
