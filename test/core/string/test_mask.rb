covers 'facets/string/mask'

test_case String do

  method :mask do

    test "makes a mask with the given empty-slot character" do
      m = "abc..123".mask('.')
      m.assert.kind_of?(String::Mask)
      m.assert == String::Mask.new("abc..123", '.')
    end

  end

end

test_case String::Mask do

  x1 = String::Mask["abc..123", '.']
  x2 = String::Mask["ab..789.", '.']

  class_method :[] do

    test "is the same as new" do
      String::Mask["abc..123", '.'].assert == String::Mask.new("abc..123", '.')
    end

  end

  method :+ do

    test "takes the other's character unless it is empty" do
      (x1 + x2).to_s.assert == "abc.7893"
      (x2 + x1).to_s.assert == "abc.7123"
    end

    test "reads an ordinary string as a mask" do
      (x1 + "ab..789.").to_s.assert == "abc.7893"
    end

    test "counts characters past the end of the shorter mask as empty" do
      ("abc".mask('.') + "..cde").to_s.assert == "abcde"
      ("..cde".mask('.') + "abc").to_s.assert == "abcde"
    end

    test "keeps the string's encoding" do
      r = "héllo..".mask('.') + ".....!!"
      r.to_s.assert == "héllo!!"
      r.to_s.encoding.assert == Encoding::UTF_8
    end

    test "does not change either mask" do
      a = String::Mask["abc..123", '.']
      a + x2
      a.to_s.assert == "abc..123"
    end

  end

  method :| do

    test "is the same as +" do
      (x1 | x2).assert == (x1 + x2)
    end

  end

  method :- do

    test "is empty where the characters match, and the other's where they differ" do
      (x1 - x2).to_s.assert == "....789."
      (x2 - x1).to_s.assert == "..c..123"
    end

  end

  method :* do

    test "keeps matching characters, and takes the other's where they differ" do
      (x1 * x2).to_s.assert == "ab..789."
      (x2 * x1).to_s.assert == "abc..123"
    end

  end

  method :& do

    test "keeps only matching characters" do
      (x1 & x2).to_s.assert == "ab......"
      (x2 & x1).to_s.assert == "ab......"
    end

  end

  method :^ do

    test "keeps a character only where the other is empty" do
      (x1 ^ x2).to_s.assert == "..c.7..3"
      (x2 ^ x1).to_s.assert == "..c.7..3"
    end

  end

  method :== do

    test "is true for a mask with the same characters and empty slots" do
      x1.assert == String::Mask["abc..123", '.']
      x1.refute == x2
    end

    test "is true for a mask made with another empty-slot character" do
      x1.assert == String::Mask["abc__123", '_']
    end

    test "is false for an ordinary string, either way round" do
      (x1 == "abc..123").assert == false
      (x1 == x1.to_str).assert == false
      ("abc..123" == x1).assert == false
      (x1.to_s == "abc..123").assert == true
    end

    test "is false for anything that isn't a string" do
      (x1 == 5).assert == false
      (x1 == nil).assert == false
    end

  end

  method :hash do

    test "lets equal masks be the same hash key" do
      h = { String::Mask["abc..123", '.'] => 1 }
      h[String::Mask["abc..123", '.']].assert == 1
      h["abc..123"].assert == nil
    end

  end

  method :to_s do

    test "gives the string with its empty-slot character" do
      x1.to_s.assert == "abc..123"
      x1.to_s.assert.instance_of?(String)
    end

    test "uses the substitute character when none was given" do
      m = String::Mask.new("ab\x1Ad")
      m.to_s.assert == "ab\x1Ad"
      (m + "..c.".mask('.')).to_s.assert == "abcd"
    end

  end

  method :to_str do

    test "gives the underlying string, with ESC in each empty slot" do
      x1.to_str.assert == "abc\x1A\x1A123"
    end

  end

  method :mask do

    test "gives a mask of the same slots with another character" do
      x1.mask('_').to_s.assert == "abc__123"
      x1.to_s.assert == "abc..123"
    end

  end

  method :apply do

    test "calls a method on the string and makes a mask of the result" do
      m = x1.apply(:upcase)
      m.assert.kind_of?(String::Mask)
      m.to_s.assert == "ABC..123"
    end

  end

  method :replace do

    test "replaces the underlying string" do
      m = String::Mask["abc", '.']
      m.replace("xyz")
      m.to_s.assert == "xyz"
    end

  end

  method :method_missing do

    test "passes other methods to the string" do
      x1.size.assert == 8
      x1.assert.respond_to?(:upcase)
    end

    test "raises NoMethodError for a method a string doesn't have" do
      NoMethodError.assert.raised? { x1.no_such_method }
      x1.refute.respond_to?(:no_such_method)
    end

  end

  method :inspect do

    test "is the inspection of the string" do
      x1.inspect.assert == '"abc..123"'
    end

  end

end
