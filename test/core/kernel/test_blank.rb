covers 'facets/kernel/blank'

testcase Kernel do

  unit :blank? do
    Object.new.refute.blank?
  end

end

testcase NilClass do

  unit :blank? do
    nil.assert.blank?
  end

end

testcase FalseClass do

  unit :blank? do
    false.assert.blank?
  end

end

testcase TrueClass do

  unit :blank? do
    true.refute.blank?
  end

end

testcase Array do

  unit :blank? do
    [ ].assert.blank?
    [1].refute.blank?
  end

end

testcase Hash do

  unit :blank? do
    {}.assert.blank?
    {:a=>1}.refute.blank?
  end

end

testcase String do

  unit :blank? do
    "xyz".refute.blank?
    "   ".assert.blank?
  end

end

testcase Numeric do

  unit :blank? do
    0.refute.blank?
  end

  unit :blank? do
    10.refute.blank?
  end

  unit :blank? do
    10.0.refute.blank?
  end

end

