covers 'facets/file/read_list'

tests File do

  test_file = 'tmp/read_list.txt'

  metaunit :read_list do
    File.open(test_file, 'w'){ |f| f << "line 1\nline 2\n#line 3" }
    File.read_list(test_file).assert == ['line 1', 'line 2']
  end

end
