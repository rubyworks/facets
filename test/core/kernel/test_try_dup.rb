covers 'facets/kernel/try_dup'

tests Kernel do
  unit :try_dup do
    obj1 = Object.new
    obj2 = obj1.try_dup
    obj2.equal?(obj1).assert == false
  end

  unit :dup! do
    obj1 = Object.new
    obj2 = obj1.dup!
    obj2.equal?(obj1).assert == false
  end
end

tests TrueClass do
  unit :try_dup do
    true.try_dup.assert == true
  end
end

tests FalseClass do
  unit :try_dup do
    false.try_dup.assert == false
  end
end

tests NilClass do
  unit :try_dup do
    nil.try_dup.assert == nil
  end
end

tests Numeric do
  unit :try_dup do
    10.try_dup.assert == 10
  end
end

tests Symbol do
  unit :try_dup do
    :A.try_dup.assert == :A
  end
end

