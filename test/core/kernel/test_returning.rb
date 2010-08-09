Covers 'facets/kernel/returning'

Case Object do

  Unit :returning do
    foo = returning( values = [] ) do
      values << 'bar'
      values << 'baz'
    end
    foo.assert == ['bar', 'baz']
  end

end
