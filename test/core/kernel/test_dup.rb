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
  unit :dup? do |o|
    true.refute.dup?
  end

  unit :clone? do |o|
    true.refute.clone?
  end
end

tests FalseClass do
  unit :dup? do |o|
    false.refute.dup?
  end

  unit :clone? do |o|
    false.refute.clone?
  end
end

tests NilClass do
  unit :dup? do |o|
    nil.refute.dup?
  end

  unit :clone? do |o|
    nil.refute.clone?
  end
end

tests Symbol do
  unit :dup? do |o|
    :a.refute.dup?
  end

  unit :clone? do |o|
    :a.refute.clone?
  end
end

tests Numeric do
  unit :dup? do |o|
    1.refute.dup?
  end

  unit :clone? do |o|
    1.refute.clone?
  end
end

