## String#compress_lines

    require 'facets/string/compress_lines'

Matches any whitespace (including newline) at beginning and end of lines,
and replaces with a single space.

    string = <<-QUERY.compress_lines
      SELECT name
      FROM users
    QUERY
    string.assert == "SELECT name FROM users"

Matches any whitespace (including newline) at beginning and end of lines,
and removes it.

    string = <<-QUERY.compress_lines(false)
      SELECT name
      FROM users
    QUERY
    string.assert == "SELECT nameFROM users"

