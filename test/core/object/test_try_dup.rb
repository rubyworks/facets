covers 'facets/object/try_dup'

test_case Object do
  method :try_dup do
    test do
      obj1 = Object.new
      obj2 = obj1.try_dup
      obj2.equal?(obj1).assert == false
    end
  end

  method :dup! do
    test "is an alias for #try_dup" do
      obj1 = Object.new
      obj2 = obj1.dup!
      obj2.equal?(obj1).assert == false
    end
  end
end

test_case TrueClass do
  method :try_dup do
    test do
      true.try_dup.assert == true
    end
  end
end

test_case FalseClass do
  method :try_dup do
    test do
      false.try_dup.assert == false
    end
  end
end

test_case NilClass do
  method :try_dup do
    test do
      nil.try_dup.assert == nil
    end
  end
end

test_case Numeric do
  method :try_dup do
    test do
      10.try_dup.assert == 10
    end
  end
end

test_case Symbol do
  method :try_dup do
    test do
      :A.try_dup.assert == :A
    end
  end
end
