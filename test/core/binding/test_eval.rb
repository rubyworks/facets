covers 'facets/binding/eval'

test_case Binding do

  x = "hello"
  bind = binding

  method :eval do
    test do
      bind.eval("x").assert == "hello"
    end
  end

end

