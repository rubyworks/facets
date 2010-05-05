Covers 'facets/module/basename.rb'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :basename do
    ExampleModule::ExampleClass.basename.assert == "ExampleClass"
  end

end

