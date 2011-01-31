covers 'facets/uri'

tests URI do

  meta :hash_to_query do
    h = { :a=>1, :b=>2 }
    r = URI.hash_to_query(h)
    assert(r == "a=1;b=2" || r == "b=2;a=1")
  end

end

tests Object do

  unit :uri do
    "abc%3Fxyz".assert == uri("abc?xyz")
  end

  unit :unuri do
    "abc?xyz".assert == unuri("abc%3Fxyz")
  end

end

tests Hash do

  unit :to_uri do
    h = { :a=>1, :b=>2 }
    r = h.to_uri
    assert(r == "a=1;b=2" || r == "b=2;a=1")
  end

end
