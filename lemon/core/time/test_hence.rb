require 'facets/time/hence'
#require 'time' # for parse method

Case Time do

  def test_change_years
    e = Time.utc(2007,11, 1, 18,30,57)
    r = Time.utc(2008,11, 1, 18,30,57).ago(1, :years)
    r.assert == e

    e = Time.utc(2008,11, 1, 18,30,57)
    r = Time.utc(2007,11, 1, 18,30,57).hence(1, :years)
    r.assert == e                 
  end

  def test_change_weeks
    e = Time.utc(2008,11,24, 18,30,57)
    r = Time.utc(2008,12, 1, 18,30,57).ago(1, :weeks)
    r.assert == e

    e = Time.utc(2008,12, 1, 18,30,57)
    r = Time.utc(2008,11,24, 18,30,57).hence(1, :weeks)
    r.assert == e
  end

  def test_change_days
    e = Time.utc(2008,11,30, 18,30,57)
    r = Time.utc(2008,12, 1, 18,30,57).ago(1, :days)
    r.assert == e

    e = Time.utc(2008,12, 1, 18,30,57)
    r = Time.utc(2008,11,30, 18,30,57).hence(1, :days)
    r.assert == e
  end

  def test_change_hours
    e = Time.utc(2008,11,30, 23,30,57)
    r = Time.utc(2008,12, 1,  0,30,57).ago(1, :hours)
    r.assert == e

    e = Time.utc(2008,12, 1,  0,30,57)
    r = Time.utc(2008,11,30, 23,30,57).hence(1, :hours)
    r.assert == e
  end

  def test_change_minutes
    e = Time.utc(2008,11,30, 23,58,57)
    r = Time.utc(2008,12, 1,  0, 0,57).ago(2, :minutes)
    r.assert == e

    e = Time.utc(2008,12, 1,  0, 0,57)
    r = Time.utc(2008,11,30, 23,58,57).hence(2, :minutes)
    r.assert == e
  end

  def test_change_seconds
    e = Time.utc(2008,11,30, 23,59,57)
    r = Time.utc(2008,12, 1,  0, 0, 1).ago(4, :seconds)
    r.assert == e

    e = Time.utc(2008,12, 1,  0, 0, 1)
    r = Time.utc(2008,11,30, 23,59,57).hence(4, :seconds)
    r.assert == e
  end

  #-------------------------------------------------------------------------------------------------
  # Months are the tricky one, so they get their own little section

  def test_change_month_no_year_wrap
    e = Time.utc(2008,11, 1)
    r = Time.utc(2008,12, 1).ago(1, :months)
    r.assert == e

    e = Time.utc(2008,12, 1)
    r = Time.utc(2008,11, 1).hence(1, :months)
    r.assert == e
  end

  def test_change_month_with_year_wrap_due_to_month
    e = Time.utc(2007,12, 1)
    r = Time.utc(2008, 1, 1).ago(1, :months)
    r.assert == e

    e = Time.utc(2008, 1, 1)
    r = Time.utc(2007,12, 1).hence(1, :months)
    r.assert == e
  end

  def test_change_month_with_12_or_more_converts_extra_months_into_a_year_adjustment
    e = Time.utc(2007, 1, 1)
    r = Time.utc(2008, 1, 1).ago(12, :months)
    r.assert == e

    e = Time.utc(2008, 1, 1)
    r = Time.utc(2007, 1, 1).hence(12, :months)
    r.assert == e

    e = Time.utc(2006,11, 1)
    r = Time.utc(2008,12, 1).ago(25, :months)
    r.assert == e

    e = Time.utc(2008,12, 1)
    r = Time.utc(2006,11, 1).hence(25, :months)
    r.assert == e
  end

  def test_change_month_with_12_or_more_AND_year_wrap_due_to_month
    # 13 months = 1 year + 1 month AND month changing from 12 to 1 when going backward means go back 1 extra  year
    e = Time.utc(2006,12, 1)
    r = Time.utc(2008, 1, 1).ago(13, :months)
    r.assert == e

    e = Time.utc(2008, 1, 1)
    r = Time.utc(2006,12, 1).hence(13, :months)
    r.assert == e

    # Smaller units should remain unchanged.
    e = Time.utc(2005, 8,20, 15,37,59)
    r = Time.utc(2006, 1,20, 15,37,59).ago(5, :months)
    r.assert == e

    e = Time.utc(2006, 1,20, 15,37,59)
    r = Time.utc(2005, 8,20, 15,37,59).hence(5, :months)
    r.assert == e
  end

  def test_passing_a_negative_number_to_ago_should_be_same_as_a_positive_number_to_hence
    e = Time.utc(2008, 1, 1)
    r = Time.utc(2006,12, 1).ago(-13, :months)
    r.assert == e

    e = Time.utc(2006, 1,20)
    r = Time.utc(2005, 8,20).ago(-5, :months)
    r.assert == e
  end

  def test_passing_a_negative_number_to_hence_should_be_same_as_a_positive_number_to_ago
    e = Time.utc(2006,12, 1)
    r = Time.utc(2008, 1, 1).hence(-13, :months)
    r.assert == e

    e = Time.utc(2005, 8,20)
    r = Time.utc(2006, 1,20).hence(-5, :months)
    r.assert == e
  end

end

