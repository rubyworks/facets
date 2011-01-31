covers 'facets/class/descendants'

testcase Class do

  a = Class.new
  b = Class.new(a)
  c = Class.new(b)

  unit :descendants do
    a.descendants.assert.include?(b)
    a.descendants.assert.include?(c)
  end

end

