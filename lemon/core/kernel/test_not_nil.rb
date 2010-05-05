Covers 'facets/kernel/not_nil'

Case Kernel do

  Unit :not_nil? do
    5.assert.not_nil?
    :x.assert.not_nil?
    false.assert.not_nil?

    nil.refute.not_nil?
  end

end
