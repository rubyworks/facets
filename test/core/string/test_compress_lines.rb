covers 'facets/string/compress_lines'

test_case String do

  method :compress_lines do

    test do
      string = <<-QUERY.compress_lines
        SELECT name
        FROM users
      QUERY

      string.assert == "SELECT name FROM users"
    end

    test do
      string = <<-QUERY.compress_lines(false)
        SELECT name
        FROM users
      QUERY

      string.assert == "SELECT nameFROM users"
    end

  end

end
