covers 'facets/uri'

test_case URI do

  class_method :query do
    test do
      h = { :a=>1, :b=>2 }
      r = URI.query(h)
      assert(r == "a=1;b=2" || r == "b=2;a=1")
    end
  end

  # this is an alias of the above
  class_method :hash_to_query do
    test do
      h = { :a=>1, :b=>2 }
      r = URI.hash_to_query(h)
      assert(r == "a=1;b=2" || r == "b=2;a=1")
    end
  end

end

test_case Object do

  method :uri do
    test do
      "abc%3Fxyz".assert == uri("abc?xyz")
    end
  end

  method :unuri do
    test do
      "abc?xyz".assert == unuri("abc%3Fxyz")
    end
  end

end

test_case Hash do

  method :to_uri do
    test do
      h = { :a=>1, :b=>2 }
      r = h.to_uri
      assert(r == "a=1;b=2" || r == "b=2;a=1")
    end
  end

end
