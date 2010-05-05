Covers 'facets/module/redirect_method'

Case Module do

  Unit :redirect_method do
    c = Class.new do
      def a1 ; 1 ; end
      redirect_method :a2 => :a1
    end

    c.new.a2.assert == 1
  end

  Unit :redirect do
    c = Class.new do
      def b1 ; 1 ; end
      redirect :b2 => :b1
    end

    c.new.b2.assert == 1
  end

end

