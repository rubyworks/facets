Covers 'facets/kernel/assign_from'

Case Kernel do

  Unit :assign_from do
    c = Struct.new(:name, :address, :zip)
    bob = c.new("Bob Sawyer", "123 Maple, Anytown NC", 12345)
    joe = c.new("Joe Pitare")

    joe.assign_from(bob, :address, :zip)

    joe.name.assert == "Joe Pitare"
    joe.address. == "123 Maple, Anytown NC"
    joe.zip.assert == 12345
  end

end

