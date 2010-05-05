Covers 'facets/hash/at'

Case Hash do

  Unit :at do
    h = { :a=>1, :b=>2 }
    h.at(:a).assert == 1
    h.at(:b).assert == 2
  end

end

