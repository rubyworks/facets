covers 'facets/array/delete_unless'

test_case Array do

  method :delete_unless do

    test 'with an explicit block' do
      [1,2,3].delete_unless{ |x| x < 2 }.assert == [1]
    end

    test 'with an implicit block' do
      [1,2,3].delete_unless(&:even?).assert == [2]
    end

  end

end
