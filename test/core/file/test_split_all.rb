covers 'facets/file/split_all'

test_case File do

  class_method :split_all do

    test do
      fp = "test/core/file"
      File.split_all(fp).assert == ['test', 'core', 'file']
    end

  end

end
