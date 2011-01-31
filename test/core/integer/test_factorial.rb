covers 'facets/integer/factorial'

testcase Integer do

  unit :factorial do
    0.factorial.assert == 1
    1.factorial.assert == 1
    2.factorial.assert == 2
    3.factorial.assert == 6
    4.factorial.assert == 24
  end

  unit :fac do
    0.fac.assert == 1
    1.fac.assert == 1
    2.fac.assert == 2
    3.fac.assert == 6
    4.fac.assert == 24
  end

end

