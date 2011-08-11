covers 'facets/file/create'

test_case File do

  class_method :create do

    test_file = 'tmp/rewrite.txt'
    test_data = 'This is a test!'

    test do
      File.create(test_file, test_data)
      File.read(test_file).assert == test_data
    end

  end

end
