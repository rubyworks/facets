Covers 'facets/kernel/in'

Case Kernel do

  Unit :in? do
    5.assert.in?(0..10)
    5.assert.in?([1,2,3,4,5])
  end

end
