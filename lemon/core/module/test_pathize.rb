Covers 'facets/module/pathize'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :pathize do
    ExampleModule::ExampleClass.pathize.assert == 'example_module/example_class'
  end

end

