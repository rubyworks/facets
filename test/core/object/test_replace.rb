covers 'facets/object/replace'

tests Object do

  unit :replace do
    c = Class.new do
      attr_reader :a, :b
      def initialize(a,b)
        @a, @b = a, b
      end
    end

    o = c.new(1,2)
    o.a.assert == 1
    o.b.assert == 2

    expect ArgumentError do
      o.replace(:a=>3, :b=>4)
    end
  end

end

tests Object do

  unit :replace do
    c = Class.new do
      attr :name
      attr :age
      def initialize(name, age)
        @name, @age = name, age
      end
    end
 
    a = c.new('bob', 60)
    a.name.assert == 'bob'
    a.age.assert == 60

    b = c.new('tom', 40)

    a.replace(b)

    a.name.assert == 'tom'
    a.age.assert == 40
  end

end

tests Struct do

  unit :replace do
    s = Struct.new(:name, :age)
 
    o = s.new('bob', 60)
    o.name.assert == 'bob'
    o.age.assert == 60

    o.replace(:name=>'tom', :age=>40)

    o.name.assert == 'tom'
    o.age.assert == 40
  end

end
