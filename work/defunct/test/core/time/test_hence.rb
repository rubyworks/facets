require 'facets/time/hence'
require 'test/unit'
require 'time'

class TC_Time_Hence < Test::Unit::TestCase

  def test_change_years
    assert_equal Time.utc(2007,11, 1, 18,30,57),
                 Time.utc(2008,11, 1, 18,30,57).ago(1, :years)

    assert_equal Time.utc(2008,11, 1, 18,30,57),
                 Time.utc(2007,11, 1, 18,30,57).hence(1, :years)
  end

  def test_change_weeks
    assert_equal Time.utc(2008,11,24, 18,30,57),
                 Time.utc(2008,12, 1, 18,30,57).ago(1, :weeks)

    assert_equal Time.utc(2008,12, 1, 18,30,57),
                 Time.utc(2008,11,24, 18,30,57).hence(1, :weeks)
  end

  def test_change_days
    assert_equal Time.utc(2008,11,30, 18,30,57),
                 Time.utc(2008,12, 1, 18,30,57).ago(1, :days)

    assert_equal Time.utc(2008,12, 1, 18,30,57),
                 Time.utc(2008,11,30, 18,30,57).hence(1, :days)
  end

  def test_change_hours
    assert_equal Time.utc(2008,11,30, 23,30,57),
                 Time.utc(2008,12, 1,  0,30,57).ago(1, :hours)

    assert_equal Time.utc(2008,12, 1,  0,30,57),
                 Time.utc(2008,11,30, 23,30,57).hence(1, :hours)
  end

  def test_change_minutes
    assert_equal Time.utc(2008,11,30, 23,58,57),
                 Time.utc(2008,12, 1,  0, 0,57).ago(2, :minutes)

    assert_equal Time.utc(2008,12, 1,  0, 0,57),
                 Time.utc(2008,11,30, 23,58,57).hence(2, :minutes)
  end

  def test_change_seconds
    assert_equal Time.utc(2008,11,30, 23,59,57),
                 Time.utc(2008,12, 1,  0, 0, 1).ago(4, :seconds)

    assert_equal Time.utc(2008,12, 1,  0, 0, 1),
                 Time.utc(2008,11,30, 23,59,57).hence(4, :seconds)
  end

  #-------------------------------------------------------------------------------------------------
  # Months are the tricky one, so they get their own little section

  def test_change_month_no_year_wrap
    assert_equal Time.utc(2008,11, 1),
                 Time.utc(2008,12, 1).ago(1, :months)

    assert_equal Time.utc(2008,12, 1),
                 Time.utc(2008,11, 1).hence(1, :months)
  end

  def test_change_month_with_year_wrap_due_to_month
    assert_equal Time.utc(2007,12, 1),
                 Time.utc(2008, 1, 1).ago(1, :months)

    assert_equal Time.utc(2008, 1, 1),
                 Time.utc(2007,12, 1).hence(1, :months)
  end

  def test_change_month_with_12_or_more_converts_extra_months_into_a_year_adjustment
    (
    assert_equal Time.utc(2007, 1, 1),
                 Time.utc(2008, 1, 1).ago(12, :months)

    assert_equal Time.utc(2008, 1, 1),
                 Time.utc(2007, 1, 1).hence(12, :months)
    )
    (
    assert_equal Time.utc(2006,11, 1),
                 Time.utc(2008,12, 1).ago(25, :months)

    assert_equal Time.utc(2008,12, 1),
                 Time.utc(2006,11, 1).hence(25, :months)
    )
  end

  def test_change_month_with_12_or_more_AND_year_wrap_due_to_month
    (
    # 13 months = 1 year + 1 month AND month changing from 12 to 1 when going backward means go back 1 extra  year
    assert_equal Time.utc(2006,12, 1),
                 Time.utc(2008, 1, 1).ago(13, :months)

    assert_equal Time.utc(2008, 1, 1),
                 Time.utc(2006,12, 1).hence(13, :months)

    )
    (
    # Smaller units should remain unchanged.
    assert_equal Time.utc(2005, 8,20, 15,37,59),
                 Time.utc(2006, 1,20, 15,37,59).ago(5, :months)

    assert_equal Time.utc(2006, 1,20, 15,37,59),
                 Time.utc(2005, 8,20, 15,37,59).hence(5, :months)
    )
  end

  def test_passing_a_negative_number_to_ago_should_be_same_as_a_positive_number_to_hence
    assert_equal Time.utc(2008, 1, 1),
                 Time.utc(2006,12, 1).ago(-13, :months)

    assert_equal Time.utc(2006, 1,20),
                 Time.utc(2005, 8,20).ago(-5, :months)
  end

  def test_passing_a_negative_number_to_hence_should_be_same_as_a_positive_number_to_ago
    assert_equal Time.utc(2006,12, 1),
                 Time.utc(2008, 1, 1).hence(-13, :months)

    assert_equal Time.utc(2005, 8,20),
                 Time.utc(2006, 1,20).hence(-5, :months)
  end

end
