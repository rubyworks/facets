covers 'facets/file/rewrite'

tests File do

  test_file = 'tmp/rewrite.txt'
  test_data = 'This is a test!'

  context do
    File.open(test_file, 'w'){ |w| w << test_data }
  end

  metaunit :rewrite do
    File.rewrite(test_file){ |s| s.reverse }
    File.read(test_file).assert == test_data.reverse
  end

  metaunit :rewrite! do
    File.rewrite!(test_file){ |s| s.reverse! }
    File.read(test_file).assert == test_data.reverse
  end

end
