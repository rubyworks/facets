covers 'facets/file/split_all'

tests File do

  metaunit :split_all do
    fp = "test/core/file"
    File.split_all(fp).assert == ['test', 'core', 'file']
  end

end
