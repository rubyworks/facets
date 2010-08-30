covers 'facets/enumerable/uniq_by'

testcase Enumerable do

  unit :uniq_by do
    e = [-5, -4, -3, -2, -1, 0]
    r = (-5..5).to_a.uniq_by{ |i| i*i }
    r.assert == e
  end

  #unit :uniq_by! do
  #  e = [-5, -4, -3, -2, -1, 0]
  #  r = (-5..5).to_a
  #  r.uniq_by!{ |i| i*i }
  #  r.assert == e
  #end

end

