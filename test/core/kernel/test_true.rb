covers 'facets/kernel/true'

testcase Kernel do

  unit :true? => "nothing is true? but true itself" do
    true.assert.true?

    nil.refute.true?
    false.refute.true?
    1.refute.true?
    :a.refute.true?
  end

  unit :false? => "nothing is false? but false itself" do
    false.assert.false?

    nil.refute.false?
    true.refute.false?
    1.refute.false?
    :a.refute.false?
  end

end
