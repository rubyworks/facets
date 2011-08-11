covers 'facets/hash/dearray_values'

test_case Hash do

  method :dearray_values do

    test do
      h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
      x = { :a=>1, :b=>1, :c=>3, :d=>nil }
      h.dearray_values.assert == x
    end

  end

  method :dearray_singular_values do

    test do
      h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
      x = { :a=>1, :b=>[1,2], :c=>3, :d=>nil }
      h.dearray_singular_values.assert == x
    end

  end

end

