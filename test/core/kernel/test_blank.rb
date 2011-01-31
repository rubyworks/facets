covers 'facets/kernel/blank'

# NOTE: Using x.assert.blank? here caused AE some issues
# b/c of problems with Assertor. Basically Assertor needs
# to subclass BasicObject, but Ruby 1.9 has constant lookup
# issues with BasicObject that need address. So in this case
# we'll just use the old-school `assert foo` syntax.

testcase Kernel do

  unit :blank? do
    refute Object.new.blank?
  end

end

testcase NilClass do

  unit :blank? do
    assert nil.blank?
  end

end

testcase FalseClass do

  unit :blank? do
    assert false.blank?
  end

end

testcase TrueClass do

  unit :blank? do
    refute true.blank?
  end

end

testcase Array do

  unit :blank? do
    assert [].blank?
    refute [1].blank?
  end

end

testcase Hash do

  unit :blank? do
    assert( {}.blank? )
    refute( {:a=>1}.blank? )
  end

end

testcase String do

  unit :blank? do
    refute "xyz".blank?
    assert "   ".blank?
  end

end

testcase Numeric do

  unit :blank? do
    refute 0.blank?
  end

  unit :blank? do
    refute 10.blank?
  end

  unit :blank? do
    refute 10.0.blank?
  end

end

