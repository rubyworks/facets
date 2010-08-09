Covers 'facets/module/methodize'

require File.dirname(__FILE__) + '/test_helper.rb'

Case Module do

  Unit :methodize do
    ExampleModule::ExampleClass.methodize.assert == "example_module__example_class"
  end

end

