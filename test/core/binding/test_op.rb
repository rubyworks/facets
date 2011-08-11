covers 'facets/binding/op'

test_case Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  method :[] do
    test do
      bind["x"].assert == "hello"
    end
  end

  method :[]= do
    test do
      bind["x"] = "goodbye"
      bind["x"].assert == "goodbye"
    end
  end

end
