covers 'facets/string/camelcase'

test_case String do

  method :camelcase do

    test do
      "Camel_case".camelcase.assert == "CamelCase"
    end

    test "converts underscore to captialized" do
      "abc_xyz".camelcase.assert == "abcXyz"
      "abc____xyz".camelcase.assert == "abcXyz"
    end

    test "can captialize at spaces" do
      "abc xyz".camelcase(' ').assert == "abcXyz"
      "abc  xyz".camelcase(' ').assert == "abcXyz"
    end

    test "can capitalize at arbitrary string" do
      "abc;xyz".camelcase(';').assert == "abcXyz"
      "abc//xyz".camelcase('//').assert == "abcXyz"
    end

    test "can captialize at regexp" do
      "abc\nxyz".camelcase(/\s/).assert == "abcXyz"
      "abc\txyz".camelcase(/\s/).assert == "abcXyz"
    end

    # this functionality is in String#modulize instead
    test "does not convert paths to module names" do
      'my_module/my_class'.camelcase.refute  == 'MyModule::MyClass'
      '/my_module/my_class'.camelcase.refute == '::MyModule::MyClass'
    end

    # this functionality is in String#modulize instead
    test "does not convert methods to module names" do
      'My_module__my_class'.camelcase.refute   == 'MyModule::MyClass'
      '__My_module__my_class'.camelcase.refute == '::MyModule::MyClass'
    end

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

end
