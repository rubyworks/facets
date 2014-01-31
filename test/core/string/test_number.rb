covers 'facets/string/number'

test_case String do

  method :number? do

    test do
      x = "1.23\n"
      x.number?.assert == true
    end

    test do
      x = "123_456_789_123_456_789.123_456_000_111\n"
      x.number?.assert == true
    end

    test do
      x = ".123\n"
      x.number?.assert == false
    end

    test do
      x = "123_\n"
      x.number?.assert == false
    end

    test do
      x = "_123\n"
      x.number?.assert == false
    end

    test do
      x = "23_456_789_123_456_.245\n"
      x.number?.assert == false
    end

    test do
      x = "23_456_789_123_456._245\n"
      x.number?.assert == false
    end

  end

end