covers 'facets/file/create'

tests File do

  test_file = 'tmp/rewrite.txt'
  test_data = 'This is a test!'

  metaunit :create do
    File.create(test_file, test_data)
    File.read(test_file).assert == test_data
  end

end
