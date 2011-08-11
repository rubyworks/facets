covers 'facets/object/dup'

# TODO: Improve object/dup tests.

test_case Object do
  setup "ordinary object" do
    @o = Object.new
  end

  method :dup? do
    test { assert @o.dup? }
  end

  method :clone? do
    test { assert @o.clone? }
  end

  method :dup! do
    test { assert @o.dup! }
  end

  method :try_dup do |o|
    test { assert @o.try_dup }
  end
end

test_case TrueClass do
  method :dup? do
    test { refute true.dup? }
  end

  method :clone? do
    test { refute true.clone? }
  end

  method :dup! do
    test { assert true.dup! }
  end

  method :try_dup do
    test { assert true.try_dup }
  end
end

test_case FalseClass do
  method :dup? do
    test { refute false.dup? }
  end

  method :clone? do
    test { refute false.clone? }
  end

  method :dup! do
    test { false.dup!.assert == false }
  end

  method :try_dup do
    test { false.try_dup.assert == false }
  end
end

test_case NilClass do
  method :dup? do
    test { refute nil.dup? }
  end

  method :clone? do
    test { refute nil.clone? }
  end

  method :dup! do
    test { nil.dup!.assert == nil }
  end

  method :try_dup do
    test { nil.try_dup.assert == nil }
  end
end

test_case Symbol do
  method :dup? do
    test { refute :a.dup? }
  end

  method :clone? do
    test { refute :a.clone? }
  end

  method :dup! do
    test { :a.dup!.assert == :a }
  end

  method :try_dup do
    test { :a.try_dup.assert == :a }
  end
end

test_case Numeric do
  method :dup? do
    test { refute 1.dup? }
  end

  method :clone? do
    test { refute 1.clone? }
  end

  method :dup! do
    test { 1.dup!.assert == 1 }
  end

  method :try_dup do
    test { 1.try_dup.assert == 1 }
  end
end
