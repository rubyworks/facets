require 'facets/class/cattr.rb'

class MockObject
  def initialize
    @@a = 10
  end
  def b ; @@b ; end
end

TestCase Class do

  Unit :cattr do
    Exception.refute.raised? do
      MockObject.class_eval{ cattr :a }
    end
    t = MockObject.new
    t.a.assert == 10
  end

  Unit :cattr_reader do
    Exception.refute.raised? do
      MockObject.class_eval { cattr_reader :a }
    end
    t = MockObject.new
    t.a.assert == 10
  end

  Unit :cattr_writer do
    Exception.refute.raised? do
      MockObject.class_eval { cattr_writer :b }
    end
    t = MockObject.new
    t.b = 5
    t.b.assert == 5
  end

  Unit :cattr_accessor do
    Exception.refute.raised? do
      MockObject.class_eval { cattr_accessor :c }
    end
    t = MockObject.new
    t.c = 50
    t.c.assert == 50
  end

end

