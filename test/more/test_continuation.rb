require 'facets/continuation'
require 'test/unit'

if defined?(Continuation)

  class TC_Continuation < Test::Unit::TestCase

    def test_create
      assert_nothing_raised { c, r = Continuation.create }
    end

  end

end

