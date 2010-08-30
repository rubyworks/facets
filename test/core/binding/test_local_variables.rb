covers 'facets/binding/local_variables'

testcase Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  unless RUBY_VERSION > "1.9"

    unit :local_variables do
      bind.local_variables.assert == ["bind", "x", "b", "a"]
    end

  else

    unit :local_variables do
      bind.local_variables.assert == [:bind, :x, :b, :a]
    end

  end

end

