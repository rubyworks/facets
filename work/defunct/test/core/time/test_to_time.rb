require 'facets/time/to_time'
require 'test/unit'

class TestTimeConversion < Test::Unit::TestCase

  def test_to_time
    t = Time.now #parse('4/20/2005 15:37')
    assert_instance_of( ::Time, t.to_time )
  end

end

