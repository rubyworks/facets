Covers 'facets/module/prepend'

Case Module do

  Unit :prepend => "module method" do
    m = Module.new do
      def q; "qm"; end
    end

    n = Module.new do
      prepend m
      def q; "qn"; end
    end

    x = Class.new do
      include n
    end

    n.q.assert == "qm"
  end

  # Wish this worked. 
  # x.new.q.assert == "qm"

end

