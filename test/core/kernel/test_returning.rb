covers 'facets/kernel/returning'

test_case Kernel do

  method :returning do

    test do
      foo = returning( values = [] ) do
        values << 'bar'
        values << 'baz'
      end
      foo.assert == ['bar', 'baz']
    end

  end

end
