covers 'facets/kernel/assign'

tests Kernel do

  c = Struct.new(:name, :address, :zip)

  unit :assign => "with arguments" do
    bob = c.new

    bob.assign(:name, "Bob Sawyer")
    bob.assign(:address, "123 Maple, Anytown NC")
    bob.assign(:zip, 12345)

    bob.name.assert == "Bob Sawyer"
    bob.address.assert == "123 Maple, Anytown NC"
    bob.zip.assert == 12345
  end

  unit :assign => "with hash" do
    bob = c.new

    x = { :name => "Bob Sawyer", :address => "123 Maple, Anytown NC", :zip => 12345 }

    bob.assign(x)

    bob.name.assert == x[:name]
    bob.address.assert == x[:address]
    bob.zip.assert == x[:zip]
  end

  unit :assign => "with associative array" do
    bob = c.new

    x = [[:name, "Bob Sawyer"], [:address, "123 Maple, Anytown NC"], [:zip, 12345]]

    bob.assign(x)

    bob.name.assert == "Bob Sawyer"
    bob.address.assert == "123 Maple, Anytown NC"
    bob.zip.assert == 12345
  end

  #unit :assign => "with block" do
  #  bob = c.new
  #
  #  x = lambda {|s| s.name = "Bob Sawyer"; s.address = "123 Maple, Anytown NC"; s.zip = 12345 }
  #
  #  bob.assign(&x)
  #
  #  bob.name.assert == "Bob Sawyer"
  #  bob.address.assert == "123 Maple, Anytown NC"
  #  bob.zip.assert == 12345
  #end

end

