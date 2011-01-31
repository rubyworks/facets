covers 'facets/kernel/returning'

tests Kernel do

  unit :returning do
    foo = returning( values = [] ) do
      values << 'bar'
      values << 'baz'
    end
    foo.assert == ['bar', 'baz']
  end

end
