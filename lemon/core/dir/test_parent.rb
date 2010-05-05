Covers 'facets/dir/parent'

Case Dir do

  Unit :parent do
    Dir.assert.parent?("a/b/c", "a/b/c/d")
  end

end

