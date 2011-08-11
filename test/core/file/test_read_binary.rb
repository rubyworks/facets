covers 'facets/file/read_binary'

test_case File do

  # TODO: Is this even really testable?
  class_method :read_binary do

    test_file = 'tmp/read_binary.txt'
    test_data = "line 1\nline 2\nline 3"

    test do
      File.open(test_file, 'w'){ |f| f << test_data }
      File.read_binary(test_file).assert == test_data
    end

  end

end

