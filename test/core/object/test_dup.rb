covers 'facets/object/dup'

# TODO: Improve object/dup tests.

tests Object do
  setup "ordinary object" do
    Object.new
  end

  unit :dup? do |o|
    assert o.dup?
  end

  unit :clone? do |o|
    assert o.clone?
  end

  unit :dup! do |o|
    assert o.dup!
  end

  unit :try_dup do |o|
    assert o.try_dup
  end
end

tests TrueClass do
  unit :dup? do
    refute true.dup?
  end

  unit :clone? do
    refute true.clone?
  end

  unit :dup! do
    assert true.dup!
  end

  unit :try_dup do
    assert true.try_dup
  end
end

tests FalseClass do
  unit :dup? do
    refute false.dup?
  end

  unit :clone? do
    refute false.clone?
  end

  unit :dup! do
    false.dup!.assert == false
  end

  unit :try_dup do
    false.try_dup.assert == false
  end
end

tests NilClass do
  unit :dup? do
    refute nil.dup?
  end

  unit :clone? do
    refute nil.clone?
  end

  unit :dup! do
    nil.dup!.assert == nil
  end

  unit :try_dup do
    nil.try_dup.assert == nil
  end
end

tests Symbol do
  unit :dup? do
    refute :a.dup?
  end

  unit :clone? do
    refute :a.clone?
  end

  unit :dup! do
    :a.dup!.assert == :a
  end

  unit :try_dup do
    :a.try_dup.assert == :a
  end
end

tests Numeric do
  unit :dup? do
    refute 1.dup?
  end

  unit :clone? do
    refute 1.clone?
  end

  unit :dup! do
    1.dup!.assert == 1
  end

  unit :try_dup do
    1.try_dup.assert == 1
  end
end

