covers 'facets/kernel/replace'

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

    o.replace(:a=>3, :b=>4)

    o.a.assert == 3
    o.b.assert == 4
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
 
    o = c.new('bob', 60)
    o.name.assert == 'bob'
    o.age.assert == 60

    o.replace(:name=>'tom', :age=>40)

    o.name.assert == 'tom'
    o.age.assert == 40
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
