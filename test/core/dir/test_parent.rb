covers 'facets/dir/parent'

tests Dir do

  metaunit :parent? do
    Dir.assert.parent?("a/b/c", "a/b/c/d")
  end

end

