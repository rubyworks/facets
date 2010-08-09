Covers 'facets/module/rename_method'

Case Module do

  Unit :rename_method do
    c = Class.new do
      def a; "A" ; end
      rename_method :b, :a
    end

    c.new.refute.respond_to?(:a)
    c.new.assert.respond_to?(:b)
  end

  Unit :rename do
    c = Class.new do
      def c; "C" ; end
      rename :d, :c
    end

    c.new.refute.respond_to?(:c)
    c.new.assert.respond_to?(:d)
  end

end

