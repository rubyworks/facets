covers 'facets/string/from_base'
covers 'facets/integer/to_base'

test_case String do

  method :from_base do

    test "gives the same result as to_i up to base 36" do
      [0, 1, 7, 255, -255, 2**70, -(2**70)].each do |n|
        (2..36).each do |b|
          s = n.to_s(b)
          s.from_base(b).assert == s.to_i(b)
          s.upcase.from_base(b).assert == s.to_i(b)
        end
      end
    end

    test "goes above base 36" do
      "47".from_base(62).assert == 255
      "Z".from_base(62).assert == 61
      "A".from_base(37).assert == 36
      "3HLszsQsP".from_base(62).assert == 809145531659995
    end

    test "case matters above base 36" do
      "a".from_base(62).assert == 10
      "A".from_base(62).assert == 36
    end

    test "reverses Integer#to_base" do
      [0, 1, 61, 62, -3844, 2**100, -(2**100)].each do |n|
        [2, 16, 36, 37, 62, "OLTWFS"].each do |b|
          n.to_base(b).from_base(b).assert == n
        end
      end
    end

    test "takes custom digits as a string or an array" do
      "LOL".from_base("OLTWFS").assert == 37
      "LOL".from_base(%w[O L T W F S]).assert == 37
      "-LOL".from_base("OLTWFS").assert == -37
    end

    test "minus is a digit when the digits include it" do
      "+-".from_base("-+").assert == 2
      "-+".from_base("-+").assert == 1
    end

    test "raises ArgumentError for a character that isn't a digit" do
      ArgumentError.assert.raised? { "g".from_base(16) }
      ArgumentError.assert.raised? { "9".from_base(8) }
      ArgumentError.assert.raised? { "1 2".from_base(10) }
      ArgumentError.assert.raised? { "x".from_base("OLTWFS") }
    end

    test "raises ArgumentError for an empty string" do
      ArgumentError.assert.raised? { "".from_base(10) }
      ArgumentError.assert.raised? { "-".from_base(10) }
    end

    test "base 256 reads the bytes, whatever the encoding" do
      "\x01\x00".from_base(256).assert == 256
      "\xFF".b.from_base(256).assert == 255
      "\x00".from_base(256).assert == 0
      "\u00e9".from_base(256).assert == 0xC3A9
      "-".from_base(256).assert == 45
    end

    test "base 256 reverses Integer#to_base" do
      [0, 1, 255, 256, 2**100].each do |n|
        n.to_base(256).from_base(256).assert == n
      end
    end

    test "base 256 raises ArgumentError for an empty string" do
      ArgumentError.assert.raised? { "".from_base(256) }
    end

    test "raises ArgumentError for a base out of range" do
      ArgumentError.assert.raised? { "1".from_base(1) }
      ArgumentError.assert.raised? { "1".from_base(63) }
      ArgumentError.assert.raised? { "1".from_base(255) }
    end

    test "raises TypeError for a base of another type" do
      TypeError.assert.raised? { "1".from_base(nil) }
    end

  end

end
