covers 'facets/module/redefine_method'

test_case Module do

  method :redefine_method do

    test do
      c = Class.new do
        def a; "a"; end
        redefine_method(:a){ nil }
      end
      c.new.a.assert == nil
    end

    test "keeps the visibility of the redefined method" do
      c = Class.new do
        private
        def a; "a"; end
      end
      c.redefine_method(:a){ "z" }
      c.private_method_defined?(:a).assert == true
    end

    # Lemon makes the method under test public while its tests run, so
    # each method's visibility is checked in the other method's block.
    test "redef is public, like ActiveSupport's redefine_method (#292)" do
      c = Class.new{ def a; "a"; end }
      c.redefine_method(:a){ "z" }
      Module.public_method_defined?(:redef).assert == true
    end

  end

  method :redef do

    test do
      c = Class.new do
        def b; "b"; end
        redef(:b){ "x" }
      end
      c.new.b.assert == "x"
    end

    test "redefine_method is public, like ActiveSupport's (#292)" do
      Module.public_method_defined?(:redefine_method).assert == true
      c = Class.new{ def a; "a"; end }
      c.redef(:a){ "z" }
      c.new.a.assert == "z"
    end

  end

end

