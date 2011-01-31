covers 'facets/module/prepend'

tests Module do

  unit :prepend  do
    m = Module.new do
      def q; "qm"; end
    end

    n = Module.new do
      def q; "qn"; end
      prepend m
    end

    x = Class.new do
      include n
    end

    x.new.q.assert == "qm"
  end

end
