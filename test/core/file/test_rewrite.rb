covers 'facets/file/rewrite'

tests File do

  test_data = 'This is a test!'

  context do
    test_file = 'tmp/rewrite.txt'
    File.open(test_file, 'w'){ |w| w << test_data }
    test_file
  end

  metaunit :rewrite do |test_file|
    File.rewrite(test_file){ |s| s.reverse }
    File.read(test_file).assert == test_data.reverse
  end

  metaunit :rewrite! do |test_file|
    File.rewrite!(test_file){ |s| s.reverse! }
    File.read(test_file).assert == test_data.reverse
  end

end
