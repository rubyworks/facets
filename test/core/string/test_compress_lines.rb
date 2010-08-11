Covers 'facets/string/compress_lines'

TestCase String do

  unit :compress_lines do
    string = <<-QUERY.compress_lines
      SELECT name
      FROM users
    QUERY

    string.assert == "SELECT name FROM users"
  end

end
