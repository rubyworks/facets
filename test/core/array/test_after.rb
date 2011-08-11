covers 'facets/array/after'

testcase Array do

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

