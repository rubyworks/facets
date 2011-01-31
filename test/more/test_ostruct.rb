covers 'facets/ostruct'

tests OpenStruct do

  unit :__update__ do
    o = OpenStruct.new(:a => 1)
    h = { :b => 2 }
    o.__update__(h)
    o.b.assert == 2
  end

  unit :__update__ do
    o = OpenStruct.new( { :a => 1 } )
    h = { :b => 2 }
    o.__update__(h)
    o.b.assert == 2
  end

  unit :__merge__ do
    o = OpenStruct.new( { :a => 1 } )
    h = { :b => 2 }
    q = o.__merge__( h )
    q.a.assert == 1
    q.b.assert == 2
  end

  unit :__merge__ do
    o1 = OpenStruct.new( { :a => 1 } )
    o2 = OpenStruct.new( { :b => 2 } )
    q = o1.__merge__( o2 )
    q.a.assert == 1
    q.b.assert == 2
  end

  unit :__merge__ => "with_hash" do
    o = OpenStruct.new( { :a => 1 } )
    h = { :b => 2 }
    q = o.__merge__(h)
    q.a.assert == 1
    q.b.assert == 2
  end

  unit :__merge__ => "two openstructs" do
    o1 = OpenStruct.new( { :a => 1 } )
    o2 = OpenStruct.new( { :b => 2 } )
    q = o1.__merge__(o2)
    q.a.assert == 1
    q.b.assert == 2
  end

  unit :instance_delegate => "store" do
    o = OpenStruct.new(:a => 1)
    o.instance_delegate.store(:a,1)
    o.a.assert == 1
  end

  unit :instance_delegate => "update" do
    o = OpenStruct.new
    o.instance_delegate.update(:a=>1)
    o.a.assert == 1
  end

  unit :[] do
    o = OpenStruct.new( { :a => 1 } )
    o[:a].assert == 1
  end

  unit :[]= do
    o = OpenStruct.new( { :a => 1 } )
    o[:b] = 2
    o.b.assert == 2
  end

  metaunit :new => "old functionality" do
    o = OpenStruct.new
    o.foo.assert.nil?
    o.foo = :bar
    o.foo.assert ==:bar
    o.delete_field(:foo)
    o.foo.assert.nil?
    o1 = OpenStruct.new(:x => 1, :y => 2)
    o1.x.assert == 1
    o1.y.assert == 2
    o2 = OpenStruct.new(:x => 1, :y => 2)
    o1.assert == o2
  end

  metaunit :new => "via block" do
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

  metaunit :new => "via hash and block" do
    person = OpenStruct.new(:gender => :M, :age => 71) do |p|
      p.name = 'John Smith'
    end
    person.name.assert == 'John Smith'
    person.gender.assert == :M
    person.age.assert == 71
    person.address.assert == nil
  end

  metaunit :new => "subclass via block" do
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

  metaunit :new => "subclass via hash and block" do
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

tests Hash do

  unit :to_ostruct do
    a = { :a => 1, :b => 2, :c => 3 }
    ao = a.to_ostruct
    ao.a.assert == a[:a]
    ao.b.assert == a[:b]
    ao.c.assert == a[:c]
  end

  unit :to_ostruct_recurse do
    a = { :a => 1, :b => 2, :c => { :x => 4 } }
    ao = a.to_ostruct_recurse
    ao.a.assert == a[:a]
    ao.b.assert == a[:b]
    ao.c.x.assert == a[:c][:x]
  end

  unit :to_ostruct_recurse => "with recursion" do
    a = {}
    a[:a] = a
    ao = a.to_ostruct_recurse
    ao.a.assert == ao
  end

  unit :to_ostruct_recurse => "advanced usage" do
    h = { 'a' => { 'b' => 1 } }
    o = h.to_ostruct_recurse( { h['a'] => h['a'] } )
    o.a['b'].assert == 1
    Hash.assert === o.a
  end

end

