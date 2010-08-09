Covers 'facets/kernel/not_nil'

Case Kernel do

  Unit :not_nil? do
    5.assert.not_nil?
  end

  Unit :not_nil? do
    :x.assert.not_nil?
  end

  Unit :not_nil? do
    false.assert.not_nil?
  end

  Unit :not_nil? do
    nil.refute.not_nil?
  end

end
