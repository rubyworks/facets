require 'facets/binding/eval'

TestCase Binding do

  x = "hello"
  @bind = binding

  Unit :eval do
    @bind.eval("x").assert == "hello"
  end

end

