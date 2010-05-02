require 'facets/dir/parent'

Case Dir do

  Unit :parent do
    assert Dir.parent?("a/b/c", "a/b/c/d")
  end

end

