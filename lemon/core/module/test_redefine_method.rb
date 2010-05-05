Covers 'facets/module/redefine_method'

Case Module do

  Unit :redefine_method do
    c = Class.new do
      def a; "a"; end
      redefine_method(:a){ nil }
    end
    c.new.a.assert == nil
  end

  Unit :redef do
    c = Class.new do
      def b; "b"; end
      redef(:b){ "x" }
    end
    c.new.b.assert == "x"
  end

end

