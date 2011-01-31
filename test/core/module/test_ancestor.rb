covers 'facets/module/ancestor'

testcase Module do

  unit :ancestor? do
    c1 = Class.new
    c2 = Class.new(c1)
    c2.assert.ancestor?(c1)
  end

end

