covers 'facets/binding/op'

testcase Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  unit :[] do
    bind["x"].assert == "hello"
  end

  unit :[]= do
    bind["x"] = "goodbye"
    bind["x"].assert == "goodbye"
  end

end
