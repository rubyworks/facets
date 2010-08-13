covers 'facets/file/read_binary'

tests File do

  test_file = 'tmp/read_binary.txt'
  test_data = "line 1\nline 2\nline 3"

  # TODO: Is this even really testable?
  metaunit :read_binary do
    File.open(test_file, 'w'){ |f| f << test_data }
    File.read_binary(test_file).assert == test_data
  end

end

