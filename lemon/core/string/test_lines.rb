Covers 'facets/string/lines'

Case String do

  # Ruby 1.9 defined #lines to keep the newline character. Yuk!
  Unit :lines do
    "a\nb\nc".lines.to_a.assert == ["a\n","b\n","c"]
  end

end

