covers 'facets/kernel/qua_class'

tests Kernel do

  instance "any object" do
    Object.new
  end

  unit :qua_class do |o|
    s = (class << o; self; end)
    o.qua_class.assert == o
  end

  unit :quaclass do |o|
    s = (class << o; self; end)
    o.quaclass.assert == o
  end

end
