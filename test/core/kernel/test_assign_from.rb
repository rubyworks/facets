covers 'facets/kernel/assign_from'

tests Kernel do

  c = Struct.new(:name, :address, :zip)

  unit :assign_from do
    bob = c.new("Bob Sawyer", "123 Maple, Anytown NC", 12345)
    joe = c.new("Joe Pitare")

    joe.assign_from(bob, :address, :zip)

    joe.name.assert == "Joe Pitare"
    joe.address. == "123 Maple, Anytown NC"
    joe.zip.assert == 12345
  end

  c1 = Class.new do
    attr_accessor :a
    attr_accessor :b
  end

  c2 = Class.new do
    attr_accessor :a
    attr_accessor :b
  end

  unit :assign_from do
    o1 = c1.new
    o1.a = 1
    o1.b = 2

    o2 = c2.new
    o2.assign_from(o1, :a, :b)

    o2.a.assert == 1
    o2.b.assert == 2
  end

end
