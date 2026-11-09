covers 'facets/array/from_base'

test_case Array do

  method :from_base do

    test "reads digit values, most significant first" do
      [1, 0].from_base(256).assert == 256
      [100, 10].from_base(256).assert == 25610
      [2, 5, 5].from_base(10).assert == 255
      [0].from_base(2).assert == 0
    end

    test "works in any base from 2 up" do
      [1, 2, 3].from_base(1000).assert == 1_002_003
      [1, 0].from_base(2**64).assert == 2**64
    end

    test "reverses Integer#digits" do
      [0, 1, 255, 2**100].each do |n|
        [2, 10, 16, 256, 1000].each do |b|
          n.digits(b).reverse.from_base(b).assert == n
        end
      end
    end

    test "raises ArgumentError for a digit out of range" do
      ArgumentError.assert.raised? { [1, 10].from_base(10) }
      ArgumentError.assert.raised? { [-1].from_base(10) }
      ArgumentError.assert.raised? { ["1"].from_base(10) }
      ArgumentError.assert.raised? { [1.0].from_base(10) }
    end

    test "raises ArgumentError for an empty array" do
      ArgumentError.assert.raised? { [].from_base(10) }
    end

    test "raises ArgumentError for a base below 2" do
      ArgumentError.assert.raised? { [0].from_base(1) }
    end

    test "raises TypeError for a base that isn't an Integer" do
      TypeError.assert.raised? { [1].from_base(10.0) }
    end

  end

end
