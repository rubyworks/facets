covers 'facets/string/squish'

test_case String do

  method :squish do

    test do
      r = %{ Multi-line
             string }.squish 
      r.assert == "Multi-line string"
    end

    test do
      r = " foo   bar    \n   \t   boo".squish
      r.assert == "foo bar boo"
    end

  end

  method :squish! do

    test do
      s = " foo   bar    \n   \t   boo"
      s.squish!
      s.assert == "foo bar boo"
    end

  end

end

