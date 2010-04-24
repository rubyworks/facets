require 'facets/binding/opvars'

TestCase Binding do

  a = 1
  b = 2
  x = "hello"

  @bind = binding

  Unit :[] do
    @bind["x"].assert == "hello"
  end

  Unit :[]= do
    @bind["x"] = "goodbye"
    @bind["x"].assert == "goodbye"
  end

end
