covers 'facets/string/each_char'

testcase String do

  unit :each_char do
    a = []
    i = "this"
    i.each_char{ |w| a << w }
    a.assert == ['t', 'h', 'i', 's']
  end

end

