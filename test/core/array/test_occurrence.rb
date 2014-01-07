covers 'facets/array/occurrence'

test_case Array do

  method :occurrence do

    test "no arguments" do
      r = [:a,:a,:b,:c,:c,:c].occurrence
      r.assert == { :a => 2, :b => 1, :c => 3 } 
    end
  
    test "with block" do
      r = [2,2,3,4,4,4].occurrence{|i| i % 2} 
      r.assert == { 0 => 5, 1 => 1 }
    end

  end

end

