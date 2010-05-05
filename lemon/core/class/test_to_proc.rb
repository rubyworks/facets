Covers 'facets/class/to_proc'

TestCase Class do

  Unit :to_proc do
    person = Struct.new(:name)
    people = ["joe"].map(&person)
    people[0].name.assert == "joe"
  end

end

