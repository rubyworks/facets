Covers 'facets/enumerable/find_yield'

Case Enumerable do
  
  Unit :find_yield => "a value" do
    r = [true].find_yield { |value| value }
    r.assert == true
  end

  Unit :find_yield => "detects correct value" do
    r = [1].find_yield { |value| value }
    r.assert == 1
  end

  Unit :find_yield => "returns value of block" do
    r = [1].find_yield { |v| v + 3 }
    r.assert == 4
  end

  Unit :find_yield => "detects first truthy value" do
    r = [false, false, 1].find_yield { |value| value }
    r.assert == 1
  end

  Unit :find_yield => "returns value when block is true" do
    r = [false].find_yield { |value| true }
    r.assert == true
  end

  Unit :find_yield => "returns early when block is true" do
    v1 = lambda { :something }
    v2 = lambda { raise "This shouldn't be called" }
    r = [v1, v2].find_yield { |obj| obj.call }
    r.assert == :something
  end

  Unit :find_yield => "returns nil when block returns false for all elements" do
    r = [1,2,3,4].find_yield { |value| false }
    r.assert == nil
  end

  Unit :find_yield => "returns nil when no elements in collection" do
    r = [].find_yield { |v| }
    r.assert == nil
  end

  Unit :find_yield => "can have return value specified when block isnt true" do
    r = [1,2,3].find_yield(:a_value){ |value| false }
    r.assert == :a_value
  end

  Unit :find_yield => "documentation correct" do
    obj1, obj2 = Object.new, Object.new

    class << obj1
      def foo?
        false
      end

      def foo
        raise
      end
    end

    class << obj2
      def foo?
        true
      end

      def foo
        "a value"
      end
    end

    obj1.foo?.assert == false
    obj2.foo?.assert == true
    obj2.foo.assert == "a value"

    result = [obj1, obj2].find_yield { |obj| obj.foo if obj.foo? }
    result.assert == "a value"
  end
end

