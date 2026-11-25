## String#each_sentence

    require 'facets/string/each_sentence'

    a = []
    "It works. Does it?".each_sentence{ |sentence| a << sentence }
    a.assert == ["It works.", "Does it?"]

