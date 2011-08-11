covers 'facets/file/rootname'

test_case File do

  class_method :rootname do

    test do
      File.rootname('test/core/file').assert == 'test'
    end

  end

end
