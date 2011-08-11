covers 'facets/enumerable/compact_map'

test_case Enumerable do

  method :compact_map do

    test do
      r = [1,2,nil,4].compact_map { |e| e }
      r.assert == [1,2,4]
    end

  end

  method :compact_collect do

    test do
      r = [1,2,nil,4].compact_collect { |e| e }
      r.assert == [1,2,4]
    end

  end

  #method :filter_collect do
  #  e = [3,4]
  #  a = [1,2,3,4].filter_collect { |n|
  #    throw(:skip) if n < 3
  #    n
  #  }
  #  assert_equal( e, a )
  #end

end
