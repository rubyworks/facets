covers 'facets/string/each_char'

test_case String do

  method :each_char do

    test do
      a = []
      i = "this"
      i.each_char{ |w| a << w }
      a.assert == ['t', 'h', 'i', 's']
    end

  end

end

