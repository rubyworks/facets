Covers 'facets/hash/inverse'

Case Hash do

  Unit :inverse do
    h1 = { :a=>1, :b=>2, :c=>2 }
    h2 = h1.inverse

    h2[1].assert == :a

    h2[2].assert.include?(:b)
    h2[2].assert.include?(:c)
  end

end

