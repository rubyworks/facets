Covers 'facets/prepend'

TestCase Class do

  module Eg

    class C
      def f
        "f"
      end
    end

    module M
      def f
        '{' + super + '}'
      end
    end

    class C
      prepend M
    end

  end

  #
  unit :prepend do
    c = Eg::C.new
    c.f.assert == "{f}"
  end

end
