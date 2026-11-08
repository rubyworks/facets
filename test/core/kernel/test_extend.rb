covers 'facets/kernel/extend'

test_case Kernel do

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

    test "with a block, warns that it's deprecated" do
      warnings = WarningRecorder.record { Object.new.extend { } }
      warnings.size.assert == 1
      warnings.first.assert =~ /Module\.new/
      # It names the caller (here Lemon, which wraps the method), not Facets.
      warnings.first.refute.include?('facets/kernel/extend.rb')
    end

    test "without a block, doesn't warn" do
      WarningRecorder.record { Object.new.extend(Comparable) }.assert == []
    end

  end

end
