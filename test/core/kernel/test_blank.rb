covers 'facets/kernel/blank'

# NOTE: Using x.assert.blank? here caused AE some issues
# b/c of problems with Assertor. Basically Assertor needs
# to subclass BasicObject, but Ruby 1.9 has constant lookup
# issues with BasicObject that need address. So in this case
# we'll just use the old-school `assert foo` syntax.

test_case Kernel do

  method :blank? do
    test do
      refute Object.new.blank?
    end
  end

end

test_case NilClass do

  method :blank? do
    test do
      assert nil.blank?
    end
  end

end

test_case FalseClass do

  method :blank? do
    test do
      assert false.blank?
    end
  end

end

test_case TrueClass do

  method :blank? do
    test do
      refute true.blank?
    end
  end

end

test_case Array do

  method :blank? do
    test do
      assert [].blank?
      refute [1].blank?
    end
  end

end

test_case Hash do

  method :blank? do
    test do
      assert( {}.blank? )
      refute( {:a=>1}.blank? )
    end
  end

end

test_case String do

  method :blank? do
    test do
      refute "xyz".blank?
      assert "   ".blank?
    end
  end

end

test_case Numeric do

  method :blank? do
    test do
      refute 0.blank?
    end
  end

  method :blank? do
    test do
      refute 10.blank?
    end
  end

  method :blank? do
    test do
      refute 10.0.blank?
    end
  end

end

