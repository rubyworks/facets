covers 'facets/string/lchomp'

test_case String do

  method :lchomp do

    test do
      s = "xxboo"
      r = s.lchomp("xx")
      r.assert == "boo"
    end

  end

  method :lchomp! do

    test do
      s = "xxboo"
      s.lchomp!("xx")
      s.assert == "boo"
    end

  end

end
