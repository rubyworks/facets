## String#each_paragraph

    require 'facets/string/each_paragraph'

    a = []
    "One.\n\nTwo.".each_paragraph{ |para| a << para }
    a.assert == ["One.", "Two."]

