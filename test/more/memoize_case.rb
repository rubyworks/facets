require 'facets/memoize'

TestCase Class do

  Instance "class with memoized attribuite" do
    Class.new do
      def initialize(a)
        @a = a
      end
      attr_accessor :a
      memoize :a
    end
  end

  unit :memoize => "returns expected values" do |c|
    o = c.new("A")
    o.a.assert == "A"
    o.a = "B"
    o.a.assert == "A"
  end

  unit :memoize => "returns identical objects" do |c|
    o = c.new("A")
    o.a.__id__.assert == o.a.__id__
    o.a = "B"
    o.a.__id__.assert == o.a.__id__
  end

end

