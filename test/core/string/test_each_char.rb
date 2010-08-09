Covers 'facets/string/each_char'

Case String do

  Unit :each_char do
    a = []
    i = "this"
    i.each_char{ |w| a << w }
    a.assert == ['t', 'h', 'i', 's']
  end

end

