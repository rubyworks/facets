covers 'facets/file/read_list'

test_case File do

  class_method :read_list do

    test_file = 'tmp/read_list.txt'

    test do
      File.open(test_file, 'w'){ |f| f << "line 1\nline 2\n#line 3" }
      File.read_list(test_file).assert == ['line 1', 'line 2']
    end

  end

end
