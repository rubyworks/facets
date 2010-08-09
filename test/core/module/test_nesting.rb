Covers 'facets/module/nesting'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :nesting do
    nest = ExampleModule::ExampleClass.nesting
    nest.assert == [ExampleModule]
  end

end

