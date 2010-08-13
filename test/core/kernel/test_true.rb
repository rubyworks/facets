covers 'facets/kernel/true'

testcase Kernel do

  unit :true? do
    true.assert.true?
    1.assert.true?
    :a.assert.true?
  end

  unit :true? do
    nil.refute.true?
    false.refute.true?
  end

  unit :false? do
    nil.assert.false?
    false.assert.false?
  end

  unit :false? do
    true.refute.false?
    1.refute.false?
    :a.refute.false?
  end

end
