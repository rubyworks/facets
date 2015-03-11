## Class#to_proc

    require 'facets/class/to_proc'

The `Class#to_proc` method provides a convenient way to create new
instances from a set of initialization data.

    person = Struct.new(:name)
    people = ["joe"].map(&person)
    people[0].name.assert == "joe"

