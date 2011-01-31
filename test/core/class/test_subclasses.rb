covers 'facets/class/subclasses'

testcase Class do

  context "class with a number of subclasses"

  c = Class.new
  x = Class.new(c)
  y = Class.new(c)
  z = Class.new(c)

  unit :subclasses do
    c.subclasses == [x, y, z]
  end

end

