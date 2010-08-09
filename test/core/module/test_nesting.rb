Covers 'facets/module/nesting'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :nesting do
    ExampleModule::ExampleClass.nest.assert == [ExampleModule, ExampleModule::ExampleClass]
  end

end

