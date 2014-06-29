covers 'facets/array/squeeze'

test_case Array do

  method :squeeze! do

    test 'default' do
      a = [1,2,2,3,3,2,1]
      a.squeeze!
      a.assert == [1,2,3,2,1]
    end

    test 'with argument' do
      a = [1,2,2,3,3,2,1]
      a.squeeze!(*[3])
      a.assert == [1,2,2,3,2,1]
    end

  end

end

