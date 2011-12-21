require 'facets/instantiable'

test_case Instantiable do

  setup do
    @m = Module.new do
      extend Instantiable

      attr :a

      def initialize( a )
        @a = a
      end
    end

    @n = Module.new do
      include Instantiable

      attr :a

      def initialize( a )
        @a = a
      end
    end
  end

  method :new do
    test do
      m = @m.new(1)
      1.assert == m.a
    end

    test do
      m = @n.new(1)
      1.assert == m.a
    end
  end

end

