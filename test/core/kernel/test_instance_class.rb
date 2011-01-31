covers 'facets/kernel/instance_class'

testcase Kernel do

  unit :instance_class do
    o = Object.new
    o.instance_class.assert == (class << o; self; end)
  end

end

