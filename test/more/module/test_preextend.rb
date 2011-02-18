covers 'facets/module/preextend'

tests Module do

  unit :preextend => "module method" do
    m = Module.new do
      def q; "qm"; end
    end

    n = Module.new do
      preextend m
      def q; "qn"; end
    end

    x = Class.new do
      include n
    end

    n.q.assert == "qm"
  end

end
