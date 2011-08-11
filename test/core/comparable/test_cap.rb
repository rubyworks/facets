covers 'facets/comparable/cap'

test_case Comparable do

  method :cap do

    test do
      3.cap(4).assert == 3
      4.cap(4).assert == 4
      5.cap(4).assert == 4
    end

  end

  method :at_most do

    test do
      3.at_most(4).assert == 3
      4.at_most(4).assert == 4
      5.at_most(4).assert == 4
    end

  end

  method :at_least do

    test do
      3.at_least(4).assert == 4
      4.at_least(4).assert == 4
      5.at_least(4).assert == 5
    end

  end

end

