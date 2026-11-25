## String#paragraphs

    require 'facets/string/paragraphs'

Paragraphs are separated by blank lines.

    x = "One.\nStill one.\n\nTwo."
    x.paragraphs.assert == ["One.\nStill one.", "Two."]

Any number of blank lines makes one separator, and a line holding only
whitespace is blank.

    x = "a\n\n \n\nb"
    x.paragraphs.assert == ["a", "b"]

