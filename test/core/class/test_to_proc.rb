covers 'facets/class/to_proc'

test_case Class do

  method :to_proc do

    test do
      person = Struct.new(:name)
      people = ["joe"].map(&person)
      people[0].name.assert == "joe"
    end

  end

end

