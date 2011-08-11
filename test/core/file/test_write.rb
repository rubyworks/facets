covers 'facets/file/write'

test_case File do

  class_method :write do

    test_file = 'tmp/write.txt'

    test do
      data = "Test data\n"

      nbytes = File.write(test_file, data)

      out = File.read(test_file)
      out.assert == data
      out.size.assert == nbytes
    end

  end

end

