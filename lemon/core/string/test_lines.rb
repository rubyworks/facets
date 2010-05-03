require 'facets/string/lines'

Case String do

  # Ruby 1.9 defined #lines to keep the newline character. Yuk!
  Unit :lines do
    lines.to_a.assert == ["a\n","b\n","c"], "a\nb\nc"
  end

end

