require 'facets/module/nesting.rb'
require 'test/unit'

class TestModuleNesting < Test::Unit::TestCase

  module M
    module N
      class C
        def n
          self.class.nesting
        end
      end
    end
  end

  def test_nesting
    assert_equal( [TestModuleNesting, M, M::N, M::N::C], M::N::C.new.n )
  end

end

