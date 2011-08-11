covers 'facets/kernel/writers'

test_case Kernel do

  method :writers do

    test do
      c = Class.new do
        attr_accessor :a
        def b=(b); @b=b; end
      end
      o = c.new
      w = o.writers

      w.assert.include?(:a=)
      w.assert.include?(:b=)
    end

    test do
      c = Class.new do
        attr_accessor :a
        def b=(b); @b=b; end
        private
        def q=(q); @q=q; end
      end
      o = c.new
      w = o.writers(:access=>:private)

      w.refute.include?(:a=)
      w.refute.include?(:b=)
      w.assert.include?(:q=)
    end

    test do
      c = Class.new do
        attr_accessor :a
        def b=(b); @b=b; end
        private
        def q=(q); @q=q; end
      end
      o = c.new
      w = o.writers(:access=>:all)

      w.assert.include?(:a=)
      w.assert.include?(:b=)
      w.assert.include?(:q=)
    end

    # TODO: Need to test more options for writers.

  end

end
