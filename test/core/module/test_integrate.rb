covers 'facets/module/integrate'

testcase Module do

  unit :integrate do
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

