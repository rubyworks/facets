covers 'facets/enumerable/occur'

test_case Enumerable do

  method :occur do

    arr = [:a,:b,:a]

    test do
      arr.occur(1).assert == [:b]
    end

    test do
      arr.occur(2).assert == [:a]
    end

    test do
      arr.occur(1..1).assert == [:b]
    end

    test do
      arr.occur{ |n| n % 2 == 0 }.assert == [:a]
    end

  end

end
