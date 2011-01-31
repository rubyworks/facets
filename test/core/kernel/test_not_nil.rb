covers 'facets/kernel/not_nil'

testcase Kernel do

  unit :not_nil? do
    5.assert.not_nil?
  end

  unit :not_nil? do
    :x.assert.not_nil?
  end

  unit :not_nil? do
    false.assert.not_nil?
  end

  unit :not_nil? do
    nil.refute.not_nil?
  end

end
