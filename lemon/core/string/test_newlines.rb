Covers 'facets/string/newlines'

Case String do

  # Since Ruby 1.9 defined #lines to keep the newline character,
  # we have defined #newlines to leave them out.
  Unit :newlines do
    "a\nb\nc".newlines.to_a.assert == ["a","b","c"]
  end

end

