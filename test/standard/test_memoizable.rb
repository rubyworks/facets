covers 'facets/memoizable'

test_case Memoizable do

  method :memoize do

    test "returns expected values" do
      c = Class.new do
        include Memoizable
        def initialize(a)
          @a = a
        end
        attr_accessor :a
        memoize :a
      end

      o = c.new("A")
      o.a.assert == "A"
      o.a = "B"
      o.a.assert == "A"
    end

    test "returns identical objects" do
      c = Class.new do
        include Memoizable
        def initialize(a)
          @a = a
        end
        attr_accessor :a
        memoize :a
      end

      o = c.new("A")
      o.a.__id__.assert == o.a.__id__
      o.a = "B"
      o.a.__id__.assert == o.a.__id__
    end

  end

end

