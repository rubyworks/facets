covers 'facets/string/newlines'

test_case String do

  # Since Ruby 1.9 defined #lines to keep the newline character,
  # we have defined #newlines to leave them out.
  method :newlines do
    test do
      "a\nb\nc".newlines.to_a.assert == ["a","b","c"]
    end
  end

end

