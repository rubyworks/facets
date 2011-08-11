covers 'facets/binding/self'

test_case Binding do

  bind = binding
  this = self

  method :self do

    test do
      bind.self == this
    end

  end

end
