covers 'facets/array/store'

testcase Array do

  setup do
     [1,2,3,4,5]
  end

  unit :store do |a|
    a.store(0, :A)
    a.assert == [:A,2,3,4,5]
  end

  unit :store do |a|
    a.store(-1, :Z)
    a.assert == [1,2,3,4,:Z]
  end

end

