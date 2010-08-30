covers 'facets/class/to_proc'

testcase Class do

  unit :to_proc do
    person = Struct.new(:name)
    people = ["joe"].map(&person)
    people[0].name.assert == "joe"
  end

end

