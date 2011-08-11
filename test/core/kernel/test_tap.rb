covers 'facets/kernel/tap'

test_case Kernel do

  method :tap do

    test do
      e = "foo"
      r = "foobar".tap{ |x| x.gsub!(/bar/, '') }
      r.assert == e
    end

    test "check internal value" do
      x = [1,2,3]
      x.tap{ |a|
        a.assert == x
      }
    end

    test "assign via tap block" do
      bob = Struct.new(:name, :address, :zip).new

      x = lambda do |s|
        s.name    = "Bob Sawyer"
        s.address = "123 Maple, Anytown NC"
        s.zip     = "12345" 
      end

      bob.tap(&x)

      bob.name.assert == "Bob Sawyer"
      bob.address.assert == "123 Maple, Anytown NC"
      bob.zip.assert == "12345"
    end

  end

end
