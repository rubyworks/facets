Covers 'facets/kernel/deep_copy'

Case Kernel do

  Context "a class with reference to another class" do
    xC = Class.new do
      attr_reader :x
      def initialize
        @x = 1
      end
    end

    Class.new do
      attr_reader :y
      define_method(:initialize) do
        @y = xC.new
      end
    end
  end

  Omit :deep_copy => "doesn't handle annonymous classes" do |c|
    o = c.new
    d = o.deep_copy
    d.y.x.assert == 1
  end

  Unit :deep_clone do |c|
    o = c.new
    d = o.deep_clone
    d.y.x.assert == 1
  end

end
