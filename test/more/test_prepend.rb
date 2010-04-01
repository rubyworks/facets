require 'test/unit'
require 'facets/prepend'

class TC_Class_Prepend < Test::Unit::TestCase

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

   #
   def test_prepend
     c = C.new
     assert_equal("{f}", c.f)
   end

end
