require 'facets/string/camelcase'

Case String do

  Unit :camelcase do
    "Camel_case".camelcase(false).assert == "camelCase"
  end

  Unit :camelcase => "converts underscore to captialized" do
    "abc_xyz".camelcase.assert == "abcXyz"
    "abc____xyz".camelcase.assert == "abcXyz"
  end

  #Unit :camelcase => "converts spaces to captialized" do
  #  "abc xyz".camelcase.assert  == "AbcXyz"
  #  "abc  xyz".camelcase.assert == "AbcXyz"
  #  "abc\txyz".camelcase.assert == "AbcXyz"
  #  "abc\nxyz".camelcase.assert == "AbcXyz"
  #end

  Unit :camelcase => "true argument converts underscore to captialized" do
    "abc_xyz".camelcase(true).assert == "AbcXyz"
    "abc____xyz".camelcase(true).assert == "AbcXyz"
  end

  Unit :camelcase => "false argument converts underscore to captialized" do
    "abc_xyz".camelcase(false).assert == "abcXyz"
    "abc____xyz".camelcase(false).assert == "abcXyz"
  end

  #Unit :camelcase => "false converts spaces to captialized" do
  #  "abc xyz".camelcase(false).assert == "abcXyz"
  #  "abc  xyz".camelcase(false).assert == "abcXyz"
  #  "abc\txyz".camelcase(false).assert == "abcXyz"
  #  "abc\nxyz".camelcase(false).assert == "abcXyz"
  #end

  Unit :camelcase => "converts paths to module names" do
    'this_is_it'.camelcase(true).assert == 'ThisIsIt'
    'my_module/my_class'.camelcase(true).assert == 'MyModule::MyClass'
    '/my_module/my_class'.camelcase(true).assert == '::MyModule::MyClass'
  end

  #Unit :camelcase => "converts methods to module names" do
  #  'my_module__my_class'.camelcase.assert == 'MyModule::MyClass'
  #  '__my_module__my_class'.camelcase.assert == '::MyModule::MyClass'
  #end

  Unit :lower_camelcase do
    "abc_xyz".lower_camelcase.assert == "abcXyz"
  end

  Unit :upper_camelcase do
    "abc_xyz".upper_camelcase.assert == "AbcXyz"
  end

end

