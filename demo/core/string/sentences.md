## String#sentences

    require 'facets/string/sentences'

    x = "It works. Does it? Yes!"
    x.sentences.assert == ["It works.", "Does it?", "Yes!"]

A period that isn't followed by whitespace doesn't end a sentence.

    x = "Pi is 3.14. See pi.rb."
    x.sentences.assert == ["Pi is 3.14.", "See pi.rb."]

A blank line ends a sentence, so a heading stands on its own.

    x = "A Heading\n\nFirst. Second."
    x.sentences.assert == ["A Heading", "First.", "Second."]

The method goes by punctuation alone, so it takes an abbreviation for the
end of a sentence.

    x = "Dr. Who is in."
    x.sentences.assert == ["Dr.", "Who is in."]

