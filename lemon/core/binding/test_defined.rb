require 'facets/binding/defined'

TestCase Binding do

  a = 1
  b = 2
  x = "hello"

  @bind = binding

  Unit :defined? do
    @bind.assert.defined?("x")
  end

end

