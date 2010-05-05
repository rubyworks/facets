Covers 'facets/module/integrate'

Case Module do

  Unit :integrate do
    m = Module.new do
      def x ; 1 ; end
    end

    c = Class.new do
      integrate m do
        rename :y, :x
      end
    end

    ic = c.new

    NoMethodError.assert.raised?{ ic.x }

    ic.y.assert == 1
  end

end

