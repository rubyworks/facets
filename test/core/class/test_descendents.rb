Covers 'facets/class/descendants'

TestCase Class do

  a = Class.new
  b = Class.new(a)
  c = Class.new(b)

  Unit :descendants do
    a.descendants.assert.include?(b)
    a.descendants.assert.include?(c)
  end

end

