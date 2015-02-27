covers 'facets/array/before'

test_case Array do

  method :before do

    setup do
      @sequence = ['a', 'b', 'c']
    end

    test "returns the previous element" do
      @sequence.before('b').assert == 'a'
      @sequence.before('c').assert == 'b'
    end

    test "loops around from back to front" do
      @sequence.before('a').assert == 'c'
    end

    test "non-member elements return nil" do
      @sequence.before('d').assert == nil
    end

  end

  method :after do

    setup do
      @sequence = ['a', 'b', 'c']
    end

    test "returns the following element" do
      @sequence.after('a').assert == 'b'
      @sequence.after('b').assert == 'c'
    end

    test "loops around from back to front" do
      @sequence.after('c').assert == 'a'
    end

    test "non-member elements return nil" do
      @sequence.after('d').assert == nil
    end

  end

end

