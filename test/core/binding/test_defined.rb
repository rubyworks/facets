covers 'facets/binding/defined'

tests Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  unit :defined? do
    bind.assert.defined?("x")
  end

end

