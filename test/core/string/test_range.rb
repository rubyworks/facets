covers 'facets/string/range'

test_case String do

  method :range do

    test do
      "a123a567a9".range(/123/).assert == (1..3)
      "a123a567a9".range(/a/).assert == (0..0)
    end

  end

  method :range_all do

    test do
      "a123a123a9".range_all(/123/).assert == [ (1..3), (5..7) ]
      "a123a567a9".range_all(/a/).assert == [ (0..0), (4..4), (8..8) ]
    end

  end

  method :range_of_line do

    test do
      a = "0123\n456\n78"
      x = [0..4, 5..8, 9..10]
      r = a.range_of_line
      r.assert == x
    end

  end

end

