covers 'facets/enumerable/take'

test_case Enumerable do

  method :take do

    test 'is finite' do
      infinite = (1..1/0.0) # infinite Enumerable
      infinite.take(5).assert == [1,2,3,4,5]
    end

  end

end

