require 'facets/kernel/heirarchically'

test_case Object do

  setup do
    m = Module.new do
      def preinitialize
        @a = 10
      end
      def a; @a ; end
    end

    @x = Class.new do
      include m
      def initialize
        hierarchical_send(:preinitialize)
      end
    end

    @y = Class.new(@x) do
      def initialize
        @a = "not 10"
        super
      end
    end
  end

  method :hierarchical_send do
    test do
      a = @x.new.a
      a.assert == 10
    end

    test 'subclass' do
      a = @y.new.a
      a.assert == 10
    end
  end

end

