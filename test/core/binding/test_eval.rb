covers 'facets/binding/eval'

testcase Binding do

  x = "hello"
  bind = binding

  unit :eval do
    bind.eval("x").assert == "hello"
  end

end

