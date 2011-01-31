covers 'facets/module/can'

testcase Module do

  unit :can do
    m = Module.new do
      def x; "x"; end 
    end

    c = Class.new do
      can m
    end

    c.x.assert == "x"
  end

end

