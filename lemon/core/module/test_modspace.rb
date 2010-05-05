Covers 'facets/module/modspace'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :modspace do
    ExampleModule::ExampleClass.modspace.assert == ExampleModule
    ExampleModule.modspace.assert == Object
  end

end

