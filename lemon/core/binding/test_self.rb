require 'facets/binding/self'

TestCase Binding do

  @bind = binding
  @self = self

  Unit :self do
    @bind.self == @self
  end

end

