covers 'facets/file/writelines'

#require File.dirname(__FILE__) + '/helpers/mockfile'
tests File do

  test_file = 'tmp/writelines.txt'
  test_data = %w[one two three four five]

  metaunit :writelines do
    File.writelines(test_file, test_data)

    out = File.readlines(test_file)
    out.map{ |l| l.chomp }.assert == test_data
  end

end

