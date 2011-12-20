require 'facets/preinitilizable'

test_case Preinitalizable

  module M
    include Preinitializable

    def preinitialize
      @a = 10
    end
  end

  class X
    include M
    def a; @a ; end
  end

  class Y < X
    def initialize
      super
    end
  end

  class_method :new do
    test do
      x = X.new
      10.assert == x.a
    end

    test do
      y = Y.new
      10.assert == y.a
    end
  end

end

