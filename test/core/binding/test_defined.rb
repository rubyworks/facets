covers 'facets/binding/defined'

test_case Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  method :defined? do
    test do
      bind.assert.defined?("x")
    end
  end

end

