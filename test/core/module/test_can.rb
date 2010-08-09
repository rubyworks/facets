Covers 'facets/module/can'

Case Module do

  Unit :can do
    m = Module.new do
      def x; "x"; end 
    end

    c = Class.new do
      can m
    end

    c.x.assert == "x"
  end

end

