covers 'facets/enumerable/filter'

test_case Enumerable do

  method :filter do

    test do
      x = (1..10000)
      x = x.filter{ |out,i| out << i if i % 2 == 0 }   # like select
      x = x.filter{ |out,i| out << i + 100 }           # like map
      x = x.take(3)

      x.assert == [102, 104, 106]
    end

  end

end

