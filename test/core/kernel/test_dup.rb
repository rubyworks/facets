covers 'facets/kernel/dup'

#tests Kernel do
#  instance "ordinary object" do
#    Object.new
#  end
#
#  unit :dup? do |o|
#    o.assert.dup?
#  end
#
#  unit :clone? do |o|
#    o.clone.dup?
#  end
#end

tests Object do
  instance "ordinary object" do
    Object.new
  end

  unit :dup? do |o|
    o.assert.dup?
  end

  unit :clone? do |o|
    o.clone.dup?
  end
end

tests TrueClass do
  unit :dup? do
    true.refute.dup?
  end

  unit :clone? do
    true.refute.clone?
  end
end

tests FalseClass do
  unit :dup? do
    false.refute.dup?
  end

  unit :clone? do
    false.refute.clone?
  end
end

tests NilClass do
  unit :dup? do
    nil.refute.dup?
  end

  unit :clone? do
    nil.refute.clone?
  end
end

tests Symbol do
  unit :dup? do
    :a.refute.dup?
  end

  unit :clone? do
    :a.refute.clone?
  end
end

tests Numeric do
  unit :dup? do
    1.refute.dup?
  end

  unit :clone? do
    1.refute.clone?
  end
end

