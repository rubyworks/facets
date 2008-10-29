# Test facets/date.rb

require 'facets/date.rb'
require 'test/unit'

class TC_Date < Test::Unit::TestCase

  def setup
    @d = Date.civil( 2005, 04, 20 )
  end

  def test_to_date
    assert_instance_of( ::Date, @d.to_date )
  end

  def test_to_time
    assert_instance_of( ::Time, @d.to_time )
  end

  def test_to_s
    assert_equal( "2005-04-20", @d.to_s )
  end

  def test_stamp_1
    assert_equal( "2005-04-20", @d.stamp )
  end

  def test_stamp_2
    assert_equal( "20 Apr", @d.stamp(:short) )
  end

  def test_stamp_3
    assert_equal( "April 20, 2005", @d.stamp(:long) )
  end

  def test_days_in_month
    assert_equal( 31, Date.new(2004,1,1).days_in_month )
  end

  def test_days_of_month
    assert_equal( (1..@d.days_in_month).to_a, @d.days_of_month )
  end

end

class TC_String_Date < Test::Unit::TestCase

  def test_to_date
    s = "2005-10-31"
    d = s.to_date
    assert_equal( 31, d.day )
    assert_equal( 10, d.month )
    assert_equal( 2005, d.year )
  end

end

class TestTimeConversion < Test::Unit::TestCase

  def test_to_date
    t = Time.now #parse('4/20/2005 15:37')
    assert_instance_of( ::Date, t.to_date )
  end

end

