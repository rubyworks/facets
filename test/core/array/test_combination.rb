covers 'facets/array/combination'

test_case Array do

  method :combination do

    test "finds pairs of combinations" do
      e = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
      a = [1,2,3,4]
      r = a.combination(2).to_a
      r.assert == e
    end

    test "can also take a block" do
      e = [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
      r = []
      a = [1,2,3,4]
      a.combination(2){ |a,b| r << [a,b] }
      r.assert == e
    end

  end

end

