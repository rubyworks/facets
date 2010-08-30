covers 'facets/hash/dearray_values'

testcase Hash do

  unit :dearray_values do
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>1, :c=>3, :d=>nil }
     h.dearray_values.assert == x
  end

  unit :dearray_singular_values do
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>[1,2], :c=>3, :d=>nil }
    h.dearray_singular_values.assert == x
  end

end

