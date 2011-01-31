covers 'facets/hash/at'

testcase Hash do

  unit :at do
    h = { :a=>1, :b=>2 }
    h.at(:a).assert == 1
    h.at(:b).assert == 2
  end

end

