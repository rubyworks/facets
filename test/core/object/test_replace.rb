covers 'facets/object/replace'

test_case Object do

  method :replace do

    test "must be the same type" do
      c = Class.new do
        attr_reader :a, :b
        def initialize(a,b)
          @a, @b = a, b
        end
      end

      o = c.new(1,2)
      o.a.assert == 1
      o.b.assert == 2

      # TODO: TypeError ?
      expect ArgumentError do
        o.replace(:a=>3, :b=>4)
      end
    end

    test do
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

end

test_case Struct do

  method :replace do

    test do
      s = Struct.new(:name, :age)
   
      o = s.new('bob', 60)
      o.name.assert == 'bob'
      o.age.assert == 60

      o.replace(:name=>'tom', :age=>40)

      o.name.assert == 'tom'
      o.age.assert == 40
    end

  end

end
