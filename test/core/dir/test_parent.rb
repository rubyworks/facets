Covers 'facets/dir/parent'

Case Dir do

  MetaUnit :parent? do
    Dir.assert.parent?("a/b/c", "a/b/c/d")
  end

end

