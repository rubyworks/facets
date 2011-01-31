covers 'facets/symbol/chomp'

testcase Symbol do

  unit :chomp do
    :ab.chomp(:b).assert == :a
  end

  unit :lchomp do
     :ab.lchomp(:a).assert == :b
  end

end

