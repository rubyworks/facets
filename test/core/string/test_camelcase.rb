covers 'facets/string/camelcase'

testcase String do

  unit :camelcase do
    "Camel_case".camelcase.assert == "CamelCase"
  end

  unit :camelcase => "converts underscore to captialized" do
    "abc_xyz".camelcase.assert == "AbcXyz"
    "abc____xyz".camelcase.assert == "AbcXyz"
  end

  #unit :camelcase => "converts spaces to captialized" do
  #  "abc xyz".camelcase.assert  == "AbcXyz"
  #  "abc  xyz".camelcase.assert == "AbcXyz"
  #  "abc\txyz".camelcase.assert == "AbcXyz"
  #  "abc\nxyz".camelcase.assert == "AbcXyz"
  #end

  unit :camelcase => "true argument converts first letter to lowercase" do
    "abc_xyz".camelcase(true).assert == "abcXyz"
    "abc____xyz".camelcase(true).assert == "abcXyz"
  end

  unit :camelcase => "false argument leaves first letter as is" do
    "abc_xyz".camelcase(false).assert == "abcXyz"
    "abc____xyz".camelcase(false).assert == "abcXyz"
    "Abc_xyz".camelcase(false).assert == "AbcXyz"
    "Abc____xyz".camelcase(false).assert == "AbcXyz"
  end

  #unit :camelcase => "false converts spaces to captialized" do
  #  "abc xyz".camelcase(false).assert == "abcXyz"
  #  "abc  xyz".camelcase(false).assert == "abcXyz"
  #  "abc\txyz".camelcase(false).assert == "abcXyz"
  #  "abc\nxyz".camelcase(false).assert == "abcXyz"
  #end

  unit :camelcase => "converts paths to module names" do
    'this_is_it'.camelcase.assert == 'ThisIsIt'
    'my_module/my_class'.camelcase.assert == 'MyModule::MyClass'
    '/my_module/my_class'.camelcase.assert == '::MyModule::MyClass'
  end

  #unit :camelcase => "converts methods to module names" do
  #  'my_module__my_class'.camelcase.assert == 'MyModule::MyClass'
  #  '__my_module__my_class'.camelcase.assert == '::MyModule::MyClass'
  #end

  unit :lower_camelcase do
    "abc_xyz".lower_camelcase.assert == "abcXyz"
    "Abc_xyz".lower_camelcase.assert == "abcXyz"
  end

  unit :upper_camelcase do
    "abc_xyz".upper_camelcase.assert == "AbcXyz"
    "Abc_xyz".upper_camelcase.assert == "AbcXyz"
  end

  unit :inter_camelcase do
    "abc_xyz".inter_camelcase.assert == "abcXyz"
    "Abc_xyz".inter_camelcase.assert == "AbcXyz"
  end

end

