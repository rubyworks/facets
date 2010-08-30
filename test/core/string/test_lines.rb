covers 'facets/string/lines'

testcase String do

  # Ruby 1.9 defined #lines to keep the newline character. Yuk!
  unit :lines do
    "a\nb\nc".lines.to_a.assert == ["a\n","b\n","c"]
  end

end

