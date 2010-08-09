Covers 'facets/kernel/object_hexid'

Case Kernel do

  Unit :object_hexid do
    o = Object.new
    "#<Object:#{o.object_hexid}>".assert == o.inspect
    #assert(o.inspect.index(o.object_hexid))
  end

end

