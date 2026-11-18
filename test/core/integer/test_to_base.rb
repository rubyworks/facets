covers 'facets/integer/to_base'

test_case Integer do

  method :to_base do

    test "gives the same result as to_s up to base 36" do
      [0, 1, 7, 255, -255, 2**70, -(2**70)].each do |n|
        (2..36).each do |b|
          n.to_base(b).assert == n.to_s(b)
        end
      end
    end

    test "goes above base 36" do
      255.to_base(62).assert == "47"
      61.to_base(62).assert == "Z"
      62.to_base(62).assert == "10"
      36.to_base(37).assert == "A"
      809145531659995.to_base(62).assert == "3HLszsQsP"
    end

    test "zero is the zero digit" do
      0.to_base(62).assert == "0"
      0.to_base("OL").assert == "O"
    end

    test "negative numbers get a leading minus" do
      -255.to_base(62).assert == "-47"
      -37.to_base("OLTWFS").assert == "-LOL"
    end

    test "takes custom digits as a string" do
      37.to_base("OLTWFS").assert == "LOL"
    end

    test "given an array holding a base, gives the digit values" do
      1000.to_base([100]).assert == [10, 0]
      256.to_base([256]).assert == [1, 0]
      255.to_base([16]).assert == [15, 15]
      0.to_base([100]).assert == [0]
      (2**70).to_base([1000]).assert == (2**70).digits(1000).reverse
    end

    test "given an array of digits, gives an array of them" do
      37.to_base(%w[O L T W F S]).assert == %w[L O L]
      37.to_base(%i[O L T W F S]).assert == %i[L O L]
      5.to_base([:zero, :one]).assert == [:one, :zero, :one]
      5.to_base(%w[zero one]).assert == %w[one zero one]
      0.to_base(%w[a b]).assert == %w[a]
    end

    test "takes numbers as digits when there is more than one" do
      6.to_base([5, 7]).assert == [7, 7, 5]
    end

    test "given an array, raises ArgumentError for a negative number" do
      ArgumentError.assert.raised? { -5.to_base([100]) }
      ArgumentError.assert.raised? { -5.to_base(%w[a b]) }
    end

    test "given an array, raises ArgumentError for a bad base or digits" do
      ArgumentError.assert.raised? { 5.to_base([1]) }
      ArgumentError.assert.raised? { 5.to_base([]) }
      ArgumentError.assert.raised? { 5.to_base(%w[a]) }
      ArgumentError.assert.raised? { 5.to_base(%w[a b a]) }
    end

    test "base 256 gives the bytes as a binary string" do
      256.to_base(256).assert == "\x01\x00".b
      255.to_base(256).assert == "\xFF".b
      0.to_base(256).assert == "\x00".b
      (2**64).to_base(256).assert == ("\x01" + "\x00" * 8).b
      256.to_base(256).encoding.assert == Encoding::BINARY
    end

    test "base 256 raises ArgumentError for a negative number" do
      ArgumentError.assert.raised? { -1.to_base(256) }
    end

    test "raises ArgumentError for a base out of range" do
      ArgumentError.assert.raised? { 1.to_base(1) }
      ArgumentError.assert.raised? { 1.to_base(63) }
      ArgumentError.assert.raised? { 1.to_base(255) }
    end

    test "raises ArgumentError for bad digits" do
      ArgumentError.assert.raised? { 1.to_base("O") }
      ArgumentError.assert.raised? { 1.to_base("OLO") }
    end

    test "raises ArgumentError for a negative number when minus is a digit" do
      ArgumentError.assert.raised? { -1.to_base("-+") }
      1.to_base("-+").assert == "+"
    end

    test "raises TypeError for a base of another type" do
      TypeError.assert.raised? { 1.to_base(16.0) }
      TypeError.assert.raised? { 1.to_base(256.0) }
    end

  end

end
