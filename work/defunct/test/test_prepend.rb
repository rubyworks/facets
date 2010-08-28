covers 'facets/class/prepend'

tests Class do

  unit :prepend => "class method" do
    m = Module.new do
      def q; "qm"; end
    end

    x = Class.new do
      prepend m
      def q; "qx"; end
    end

    x.new.q.assert == "qm"
  end

end

