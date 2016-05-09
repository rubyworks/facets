covers 'facets/array/from'

test_case Array do

  method :from do

    test do
      %w{W o r l d}.from(3).assert == ['l', 'd']
      %w{W o r l d}.from(8).assert == []
    end
  end

  method :thru do

    test do

      [1, 2, 3, 4, 5].thru(2).assert == [1, 2, 3]
      [1, 2, 3, 4, 5].thru(7).assert == [1, 2, 3, 4, 5]

    end

    test do

      [1, 2, 3, 4, 5].thru(0, 2).assert == [1, 2, 3]
      [1, 2, 3, 4, 5].thru(2, 4).assert == [3, 4, 5]

    end

    test do

      [1, 2, 3, 4, 5].thru(3, 7).assert == [4, 5]

    end

    test do

      [1, 2, 3, 4, 5].thru(6, 7).assert = []

    end

  end
end
