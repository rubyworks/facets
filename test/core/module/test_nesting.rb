covers 'facets/module/nesting'

tests Module do

  # TODO: how to test this without introducing a named constant
  # for the namespace? Don't want to do this to prevent it from
  # showing up in coverage report.

  omit unit :nesting do
    #nest = ExampleModule::ExampleClass.nesting
    #nest.assert == [ExampleModule]
  end

end

