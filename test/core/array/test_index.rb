covers 'facets/array/index'

test_case Array do

  method :index do

    test "can handle a block" do
      i = [1,2,3].index{ |e| e == 2 }
      i.assert == 1
    end

    test "when no element is found" do
      i = [1,2,3].index{ |e| e == 5 }
      i.assert.nil?
    end

  end

end

