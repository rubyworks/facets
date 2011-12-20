require 'facets/instantiable'

test_case Instantiable do

  module M
    extend Instantiable

    attr :a

    def initialize( a )
      @a = a
    end
  end

  module N
    include Instantiable

    attr :a

    def initialize( a )
      @a = a
    end
  end

  class_method :new do
    test do
      m = M.new(1)
      1.assert == m.a
    end

    test do
      m = N.new(1)
      1.assert == m.a
    end
  end

end

