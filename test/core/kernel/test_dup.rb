covers 'facets/kernel/dup'

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
end

tests TrueClass do
  unit :dup? do
    refute true.dup?
  end

  unit :clone? do
    refute true.clone?
  end
end

tests FalseClass do
  unit :dup? do
    refute false.dup?
  end

  unit :clone? do
    refute false.clone?
  end
end

tests NilClass do
  unit :dup? do
    refute nil.dup?
  end

  unit :clone? do
    refute nil.clone?
  end
end

tests Symbol do
  unit :dup? do
    refute :a.dup?
  end

  unit :clone? do
    refute :a.clone?
  end
end

tests Numeric do
  unit :dup? do
    refute 1.dup?
  end

  unit :clone? do
    refute 1.clone?
  end
end

