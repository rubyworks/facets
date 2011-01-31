covers 'facets/kernel/qua_class'

tests Kernel do

  setup "any object" do
    Object.new
  end

  unit :qua_class do |o|
    s = (class << o; self; end)
    o.qua_class.assert == s
  end

  unit :quaclass do |o|
    s = (class << o; self; end)
    o.quaclass.assert == s
  end

end
