require 'facets/class/to_proc'

Person = Struct.new(:name)

TestCase Class do

  Unit :to_proc do
    people = ["joe"].map(&Person)
    people[0].name.assert == "joe"
  end

end

