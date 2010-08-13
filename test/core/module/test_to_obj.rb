covers 'facets/module/to_obj'

tests Module do

  unit :to_obj do
    m = Module.new do
      def x; "x"; end
      def y; "y"; end
    end
    o = m.to_obj
    o.x.assert == "x"
    o.y.assert == "y"
  end

end

