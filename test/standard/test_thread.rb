covers 'facets/thread.rb'

test_case Array do

  method :threaded_map do
    test do
      r = [1,2,3].threaded_map{ |e| e + 1 }
      r.assert == [2,3,4]
    end
  end

  method :threaded_map_send do
    test do
      r = [1,2,3].threaded_map_send(:+, 1)
      r.assert == [2,3,4]
    end

    test "with_block" do
      r = [[1,2,3],[2,3,4],[3,4,5]].threaded_map_send(:select){ |x| x > 2 }
      r.assert == [[3],[3,4],[3,4,5]]
    end
  end

end
