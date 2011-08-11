covers 'facets/array/conjoin'

test_case Array do

  method :conjoin do

    setup "any array" do
      @a = [1,2,3,4]
    end

    test "like join but spaced" do
      @a.conjoin.assert == "1 2 3 4"
    end

    test "comma+space and 'and' on tail" do
      @a.conjoin(', ', ' and ').assert = "1, 2, 3 and 4"
    end

    test "comma+space and 'or' on tail using :last option" do
      @a.conjoin(', ', :last => ' or ').assert == "1, 2, 3 or 4"
    end

    test "semicolon+space and ampersand on tail using index" do
      @a.conjoin('; ', -1 => ' & ').assert == "1; 2; 3 & 4"
    end

    test "with block to determine separator" do
      r = @a.conjoin{ |i, a, b| i % 2 == 0 ? '.' : '-' }
      r.assert == "1.2-3.4"
    end

    test "very esoteric transformation" do
      r = @a.conjoin{ |i, x, y| "<#{i} #{x} #{y}>" }
      r.assert == "1<0 1 2>2<1 2 3>3<2 3 4>4"
    end

    test "with :space option" do
      r = @a.conjoin(',', '&', :space=>2)
      r.assert == "1  ,  2  ,  3  &  4"
    end

    test ":spacer option can set an alternate spacing string" do
      r = @a.conjoin('|', '>', :space=>2, :spacer=>'-')
      r.assert == "1--|--2--|--3-->--4"
    end

  end

end

