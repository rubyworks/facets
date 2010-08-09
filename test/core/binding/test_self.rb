Covers 'facets/binding/self'

TestCase Binding do

  bind = binding
  this = self

  Unit :self do
    bind.self == this
  end

end

