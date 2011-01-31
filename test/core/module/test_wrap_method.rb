covers 'facets/module/wrap_method'

testcase Module do

  unit :wrap_method do
    c = Class.new do
      def a; "A"; end
      wrap_method(:a) { |old| old.call + "B" }
    end

    c.new.a.assert == "AB"
  end

  unit :wrap do
    c = Class.new do
      def b; "B"; end
      wrap(:b) { |old| old.call + "C" }
    end

    c.new.b.assert == "BC"
  end

end

