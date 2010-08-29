covers 'facets/kernel/deep_copy'

testcase Kernel do

  context "a class with reference to another class" do
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

  omit unit :deep_copy => "doesn't handle annonymous classes" do |c|
    o = c.new
    d = o.deep_copy
    d.y.x.assert == 1
  end

  unit :deep_clone do |c|
    o = c.new
    d = o.deep_clone
    d.y.x.assert == 1
  end

end
