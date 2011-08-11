covers 'facets/dir/parent'

test_case Dir do

  class_method :parent? do

    test do
      Dir.assert.parent?("a/b/c", "a/b/c/d")
    end

  end

end

