Covers 'facets/class/descendents'

TestCase Class do

  a = Class.new
  b = Class.new(a)
  c = Class.new(b)

  Unit :descendents do
    a.descendents.assert == [c,b]
  end

end

