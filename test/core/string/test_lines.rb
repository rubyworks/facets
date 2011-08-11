covers 'facets/string/lines'

test_case String do

  # Ruby 1.9 defined #lines to keep the newline character.
  method :lines do

    test do
      "a\nb\nc".lines.to_a.assert == ["a\n","b\n","c"]
    end

  end

end

