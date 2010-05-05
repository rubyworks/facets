Covers 'facets/integer/factorial'

Case Integer do

  Unit :factorial do
    0.factorial.assert == 1
    1.factorial.assert == 1
    2.factorial.assert == 2
    3.factorial.assert == 6
    4.factorial.assert == 24
  end

end

