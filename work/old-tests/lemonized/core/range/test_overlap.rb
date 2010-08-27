require 'facets/range/overlap'
require 'test/unit'

class TestRangeOverlap < Test::Unit::TestCase

  def test_overlaps
    assert( (4..5).overlap?(3..6) )
  end

  def test_does_not_overlap
    assert(! (7..9).overlap?(3..6) )
  end

end

