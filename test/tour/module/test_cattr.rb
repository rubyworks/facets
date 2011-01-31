covers 'facets/module/cattr'

tests Class do

  setup do
    Class.new do
      def initialize
        @@a = 10
        @@b = nil
      end
      def b ; @@b ; end
    end
  end

  unit :cattr do |c|
    c.class_eval{ cattr :a }
    t = c.new
    c.a.assert == 10
    t.a.assert == 10
  end

  unit :cattr_reader do |c|
    c.class_eval{ cattr_reader :a }
    t = c.new
    c.a.assert == 10
    t.a.assert == 10
  end

  unit :cattr_writer do |c|
    c.class_eval{ cattr_writer :b }
    t = c.new
    t.b = 5
    t.b.assert == 5
  end

  unit :cattr_accessor do |c|
    c.class_eval{ cattr_accessor :c }
    t = c.new
    t.c = 50
    t.c.assert == 50
    c.c.assert == 50
  end

end

