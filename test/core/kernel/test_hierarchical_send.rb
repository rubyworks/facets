require 'facets/kernel/hierarchical_send'

test_case Object do

  setup do
    m = Module.new do
      attr :a
      def preinitialize
        @a = 10
      end
    end

    @x = Class.new do
      include m
      attr :b
      def preinitialize
        @b = 20
      end
      def initialize
        hierarchical_send(:preinitialize)
      end
    end

    @y = Class.new(@x) do
      def initialize
        @a = "not 10"
        @b = "not 20"
        super
      end
    end
  end

  method :hierarchical_send do
    test do
      x = @x.new
      x.a.assert == 10
      x.b.assert == 20
    end

    test 'subclass' do
      y = @y.new
      y.a.assert == 10
      y.b.assert == 20
    end
  end

end

