covers 'facets/file/append'

tests File do

  test_file = 'tmp/append.txt'

  metaunit :append do
    File.append(test_file, 'line 1')
    File.read(test_file).assert == "this line"
    File.append(test_file, 'line 2')
    File.read(test_file).assert == "line 1\nline 2"
  end

end

