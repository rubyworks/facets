covers 'facets/thread.rb'

tests Array do

  unit :threaded_map do
    r = [1,2,3].threaded_map{ |e| e + 1 }
    r.assert == [2,3,4]
  end

  unit :threaded_map_send do
    r = [1,2,3].threaded_map_send(:+, 1)
    r.assert == [2,3,4]
  end

  unit :threaded_map_send => "with_block" do
    r = [[1,2,3],[2,3,4],[3,4,5]].threaded_map_send(:select){ |x| x > 2 }
    r.assert == [[3],[3,4],[3,4,5]]
  end

end

