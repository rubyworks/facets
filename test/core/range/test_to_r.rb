covers 'facets/range/to_r'

testcase Range do

  unit :to_r do
    a = (0..10)
    a.to_r.assert == a
  end

  unit :to_range do
    a = (0..10)
    a.to_range.assert == a
  end

end

