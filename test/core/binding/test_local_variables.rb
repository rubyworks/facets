covers 'facets/binding/local_variables'

test_case Binding do

  a = 1
  b = 2
  x = "hello"

  bind = binding

  unless RUBY_VERSION > "1.9"

    method :local_variables do
      test do
        bind.local_variables.assert.include? "bind"
        bind.local_variables.assert.include? "x"
        bind.local_variables.assert.include? "a"
        bind.local_variables.assert.include? "b"
      end
    end

  else

    method :local_variables do
      test do
        bind.local_variables.assert.include? :bind
        bind.local_variables.assert.include? :x
        bind.local_variables.assert.include? :a
        bind.local_variables.assert.include? :b
      end
    end

  end

end

