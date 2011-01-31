covers 'facets/file/rootname'

tests File do

  metaunit :rootname do
    File.rootname('test/core/file').assert == 'test'
  end

end
