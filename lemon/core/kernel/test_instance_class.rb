Covers 'facets/kernel/instance_class'

Case Kernel do

  Unit :instance_class do
    o = Object.new
    o.instance_class.assert == (class << o; self; end)
  end

end

