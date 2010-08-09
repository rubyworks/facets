Covers 'facets/kernel/instance_assign'

Case Kernel do

  Unit :instance_assign do
    ahash = { "z"=>0, "@a"=>1, "@b"=>2 } #, "@@a"=>3 }
    instance_assign( ahash )
    @z.assert == 0
    @a.assert == 1
    @b.assert == 2
    #@@a.assert == 3
  end

end

