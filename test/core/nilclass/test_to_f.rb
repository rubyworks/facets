covers 'facets/nilclass/to_f'

testcase NilClass do

  unit :to_f do
    nil.to_f.assert == 0
  end

end

