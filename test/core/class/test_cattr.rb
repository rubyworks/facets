covers 'facets/class/cattr'

tests Class do

  mock_class = Class.new do
    def initialize
      @@a = 10
      @@b = nil
    end
    def b ; @@b ; end
  end

  unit :cattr do
    Exception.refute.raised? do
      mock_class.class_eval{ cattr :a }
    end
    t = mock_class.new
    t.a.assert == 10
  end

  unit :cattr_reader do
    Exception.refute.raised? do
      mock_class.class_eval { cattr_reader :a }
    end
    t = mock_class.new
    t.a.assert == 10
  end

  unit :cattr_writer do
    Exception.refute.raised? do
      mock_class.class_eval { cattr_writer :b }
    end
    t = mock_class.new
    t.b = 5
    t.b.assert == 5
  end

  unit :cattr_accessor do
    Exception.refute.raised? do
      mock_class.class_eval { cattr_accessor :c }
    end
    t = mock_class.new
    t.c = 50
    t.c.assert == 50
  end

end

