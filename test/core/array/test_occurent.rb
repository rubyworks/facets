covers 'facets/array/occurent'

test_case Array do

  method :occurent do

    test "set limit" do
      a = [1,2,3,4,5,
             2,3,4,5,
               3,4,5,
                 4,5,
                   5]  
      (1..5).each do |m|
        d = a.occurent(m)
        d.assert == [m]
      end
    end

    test "range" do
      a = %w{a b c d e
               b c d e
                 c d e
                   d e
                     e}
      a.occurent(1..2).sort.assert == ['a','b']
      a.occurent(1..3).sort.assert == ['a','b','c']
      a.occurent(2..3).sort.assert == ['b','c']
    end

  end

end

