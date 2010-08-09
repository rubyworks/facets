Covers 'facets/module/spacename'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :spacename do
    ExampleModule::ExampleClass.spacename.assert == 'ExampleModule'
    ExampleModule.spacename.assert == ''  # should this be nil ?
  end

end

