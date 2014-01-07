covers 'facets/array/occur'

test_case Array do

  method :occur do

    test "set limit" do
      a = [1,2,3,4,5,
             2,3,4,5,
               3,4,5,
                 4,5,
                   5]  
      (1..5).each do |m|
        d = a.occur(m)
        d.assert == [m]
      end
    end

    test "range" do
      a = %w{a b c d e
               b c d e
                 c d e
                   d e
                     e}
      a.occur(1..2).sort.assert == ['a','b']
      a.occur(1..3).sort.assert == ['a','b','c']
      a.occur(2..3).sort.assert == ['b','c']
    end

    test do
      a = [:a,:b,:a]
      a.occur(1).assert == [:b]
    end

    test do
      a = [:a,:b,:a]
      a.occur(2).assert == [:a]
    end

    test do
      a = [:a,:b,:a]
      a.occur(1..1).assert == [:b]
    end

    test do
      a = [:a,:b,:a]
      a.occur{ |n| n % 2 == 0 }.assert == [:a]
    end

  end

end
