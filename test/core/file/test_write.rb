covers 'facets/file/write'

tests File do

  test_file = 'tmp/write.txt'

  metaunit :write do
    data = "Test data\n"

    nbytes = File.write(test_file, data)

    out = File.read(test_file)
    out.assert == data
    out.size.assert == nbytes
  end

end

