Covers 'facets/module/wrap_method'

Case Module do

  Unit :wrap_method do
    c = Class.new do
      def a; "A"; end
      wrap_method(:a) { |old| old.call + "B" }
    end

    c.new.a.assert == "AB"
  end

  Unit :wrap do
    c = Class.new do
      def b; "B"; end
      wrap(:b) { |old| old.call + "C" }
    end

    c.new.b.assert == "BC"
  end

end

