covers 'facets/enumerable/ewise'

test_case Enumerable do

  method :ewise do

    test do
      a = [1,2,3]
      (a.ewise + 3).assert == [4,5,6]
      (a.ewise + [4,5]).assert == [5,7]
      (a.ewise.+([4,5],2)).assert == [[5,7],[3,4,5]]
      (a.ewise.+([4,5],3)).assert == [[5,7],[4,5,6]]
    end

  end

  method :elementwise do

    test do
      a = [1,2,3]
      (a.elementwise + 3).assert == [4,5,6]
      (a.elementwise + [4,5]).assert == [5,7]
      (a.elementwise.+([4,5],2)).assert == [[5,7],[3,4,5]]
      (a.elementwise.+([4,5],3)).assert == [[5,7],[4,5,6]]
    end

  end

end

