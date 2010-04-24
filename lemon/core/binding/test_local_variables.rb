require 'facets/binding/local_variables'

TestCase Binding do

  a = 1
  b = 2
  x = "hello"

  @bind = binding

  unless RUBY_VERSION > "1.9"

    Unit :local_variables do
      @bind.local_variables.assert == ["x", "b", "a"]
    end

  else

    Unit :local_variables do
      @bind.local_variables.assert == [:x, :b, :a]
    end

  end

end

