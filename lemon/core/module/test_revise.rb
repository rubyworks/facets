Covers 'facets/module/revise'

Case Module do

  Unit :revisal do
    m = Module.new do
      def x ; 1 ; end
    end

    c = Class.new do
      include m.revisal {
        rename :y, :x
      }
    end

    ic = c.new

    ic.y.assert == 1
    NoMethodError.assert.raised?{ ic.x }
  end

  Unit :nodef do
    c = Class.new do
      def the_undefined_method ; 'not here' ; end
      nodef :the_undefined_method
    end

    c.new.refute.respond_to?(:the_undefined_method)
  end

  Unit :remove do
    c = Class.new do
      def the_removed_method ; 'not here' ; end
      remove :the_removed_method
    end

    c.new.refute.respond_to?(:the_removed_method)
  end

end

