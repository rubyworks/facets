covers 'facets/binding/self'

testcase Binding do

  bind = binding
  this = self

  unit :self do
    bind.self == this
  end

end

