require 'facets/array/permutation'
require 'test/unit'
require 'set'

class TestEnumerablePermutation < Test::Unit::TestCase

  def test_permutation
    o = Set.new
    %w[a b c].permutation{ |x| o << x.join('') }
    r = Set.new(['abc','acb','bac','bca','cab','cba'])
    assert_equal( r, o )
  end

end
