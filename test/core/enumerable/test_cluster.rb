covers 'facets/enumerable/cluster'

test_case Enumerable do

  method :cluster do

    test "on an array" do
      a = [0, 2, 3, 5, 6, 6, 7, 13]
      e = [[0, 2], [3, 5], [6, 6], [7, 13]]
      r = a.cluster{ |x| x % 2 }
      r.assert == e
    end

    test "on an array of strings" do
      a = ["dog", "duck", "cat", "dude"]
      e = [["dog", "duck"], ["cat"], ["dude"]]
      r = a.cluster{ |x| x[0] }
      r.assert == e
    end

    test "on a hash" do
      h = {0=>0, 1=>2, 2=>4, 3=>6, 4=>8, 5=>1, 6=>3, 7=>5, 8=>7, 9=>9}
      e = [[[0, 0], [1, 2], [2, 4], [3, 6], [4, 8]], [[5, 1], [6, 3], [7, 5], [8, 7], [9, 9]]]
      r = h.cluster{ |k, v| v % 2 }.each{|a| a.sort!}
      r.assert == e
    end

    test "on an empty array" do
      r = [].cluster{ |a| a }
      r.assert == []
    end

  end

end

