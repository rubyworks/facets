Covers 'facets/module/ancestor'

Case Module do

  Unit :ancestor do
    c1 = Class.new
    c2 = Class.new(c1)
    c2.assert.ancestor?(c1)
  end

end

