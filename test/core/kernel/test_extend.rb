covers 'facets/kernel/extend'

# Facets' #extend lives in a module prepended to Kernel, so Lemon must wrap it there.
test_case Facets::KernelExtend do

  method :extend do

    test "with a block" do
      obj = Object.new
      obj.extend do
        def foo; "foo"; end
      end
      obj.foo.assert == "foo"
    end

    test "with modules and a block" do
      obj = Object.new
      obj.extend(Comparable) do
        def foo; "foo"; end
      end
      obj.assert.is_a?(Comparable)
      obj.foo.assert == "foo"
    end

    test "returns the object" do
      obj = Object.new
      obj.extend(Comparable).assert.equal?(obj)
      obj.extend { }.assert.equal?(obj)
    end

    test "without a block, as Ruby's own" do
      obj = Object.new
      obj.extend(Comparable, Enumerable)
      obj.singleton_class.ancestors[1, 2].assert == [Comparable, Enumerable]
    end

    test "with nothing raises ArgumentError, as Ruby's does" do
      expect(ArgumentError) { Object.new.extend }
    end

  end

end
