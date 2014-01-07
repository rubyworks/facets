covers 'facets/ostruct'

test_case OpenStruct do

  method :merge! do
    test do
      o = OpenStruct.new(:a => 1)
      h = { :b => 2 }
      o.merge!(h)
      o.b.assert == 2
    end

    test do
      o = OpenStruct.new( { :a => 1 } )
      h = { :b => 2 }
      o.merge!(h)
      o.b.assert == 2
    end
  end

  method :__merge__ do
    test do
      o = OpenStruct.new( { :a => 1 } )
      h = { :b => 2 }
      q = o.__merge__( h )
      q.a.assert == 1
      q.b.assert == 2
    end

    test do
      o1 = OpenStruct.new( { :a => 1 } )
      o2 = OpenStruct.new( { :b => 2 } )
      q = o1.__merge__( o2 )
      q.a.assert == 1
      q.b.assert == 2
    end

    test "with_hash" do
      o = OpenStruct.new( { :a => 1 } )
      h = { :b => 2 }
      q = o.__merge__(h)
      q.a.assert == 1
      q.b.assert == 2
    end

    test "two open structs" do
      o1 = OpenStruct.new( { :a => 1 } )
      o2 = OpenStruct.new( { :b => 2 } )
      q = o1.__merge__(o2)
      q.a.assert == 1
      q.b.assert == 2
    end
  end

  # @deprecated
  #method :instance_delegate do
  #  test "store" do
  #    o = OpenStruct.new(:a => 1)
  #    o.instance_delegate.store(:a,1)
  #    o.a.assert == 1
  #  end
  #
  #  test "update" do
  #    o = OpenStruct.new
  #    o.instance_delegate.update(:a=>1)
  #    o.a.assert == 1
  #  end
  #end

  method :[] do
    test do
      o = OpenStruct.new( { :a => 1 } )
      o[:a].assert == 1
    end
  end

  method :[]= do
    test do
      o = OpenStruct.new( { :a => 1 } )
      o[:b] = 2
      o.b.assert == 2
    end
  end

  class_method :new do
    test "old functionality" do
      o = OpenStruct.new
      o.foo.assert.nil?
      o.foo = :bar
      o.foo.assert ==:bar
      o.delete_field(:foo)
      o.foo.assert.nil?

      o1 = OpenStruct.new(:x => 1, :z => 2)
      o1.x.assert == 1
      o1.z.assert == 2

      o2 = OpenStruct.new(:x => 1, :z => 2)
      o1.assert == o2
    end

    test "via block" do
      person = OpenStruct.new do |p|
        p.name = 'John Smith'
        p.gender  = :M
        p.age     = 71
      end
      person.name.assert == 'John Smith'
      person.gender.assert ==:M
      person.age.assert == 71
      person.address.assert ==nil
    end

    test "via hash and block" do
      person = OpenStruct.new(:gender => :M, :age => 71) do |p|
        p.name = 'John Smith'
      end
      person.name.assert == 'John Smith'
      person.gender.assert == :M
      person.age.assert == 71
      person.address.assert == nil
    end

    test "subclass via block" do
      person_class = Class.new(OpenStruct)
      person = person_class.new do |p|
        p.name = 'John Smith'
        p.gender  = :M
        p.age     = 71
      end
      person.name.assert == 'John Smith'
      person.gender.assert == :M
      person.age.assert == 71
      person.address.assert == nil
    end

    test "subclass via hash and block" do
      person_class = Class.new(OpenStruct)
      person = person_class.new(:gender => :M, :age => 71) do |p|
        p.name = 'John Smith'
      end
      person.name.assert == 'John Smith'
      person.gender.assert == :M
      person.age.assert == 71
      person.address.assert ==nil
    end
  end

end

test_case Hash do

  method :to_ostruct do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      ao = a.to_ostruct
      ao.a.assert == a[:a]
      ao.b.assert == a[:b]
      ao.c.assert == a[:c]
    end

  end

  method :to_ostruct_recurse do

    test do
      a = { :a => 1, :b => 2, :c => { :x => 4 } }
      ao = a.to_ostruct_recurse
      ao.a.assert == a[:a]
      ao.b.assert == a[:b]
      ao.c.x.assert == a[:c][:x]
    end

    test "with recursion" do
      a = {}
      a[:a] = a
      ao = a.to_ostruct_recurse
      ao.a.assert == ao
    end

    test "advanced usage" do
      h = { 'a' => { 'b' => 1 } }
      o = h.to_ostruct_recurse( { h['a'] => h['a'] } )
      o.a['b'].assert == 1
      Hash.assert === o.a
    end

  end

end
