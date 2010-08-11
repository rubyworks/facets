Covers 'facets/time/ago'

TestCase Time do

  instance "January 20th 2010 at Noon" do
    Time.utc(2010,01,20,12,00,00)
  end

  unit :ago => 'years' do |t|
    t.ago(1, :year).year.assert = 2009
    t.ago(2, :years).year.assert = 2008
  end

  unit :ago => 'weeks' do |t|
    t.ago(1, :week).day.assert == 13
    t.ago(2, :weeks).day.assert == 6
  end

  unit :ago => 'days' do |t|
    t.ago(1, :day).day.assert == 19
    t.ago(2, :days).day.assert == 18
  end

  unit :ago => 'hours' do |t|
    t.ago(1, :hour).hour.assert == 11
    t.ago(2, :hours).hour.assert == 10
    t.ago(12, :hours).hour.assert == 0
  end

  unit :ago => 'minutes' do |t|
    t.ago(1, :minute).min.assert == 59
    t.ago(2, :minutes).min.assert == 58
    t.ago(60, :minutes).min.assert == 0
  end

  unit :ago => 'seconds' do |t|
    t.ago(1, :second).sec.assert == 59
    t.ago(2, :seconds).sec.assert == 58
    t.ago(60, :seconds).sec.assert == 0
  end

  #

  unit :ago => "change years" do
    e = Time.utc(2007,11, 1, 18,30,57)
    r = Time.utc(2008,11, 1, 18,30,57).ago(1, :years)
    r.assert == e
  end

  unit :ago => "change weeks" do
    e = Time.utc(2008,11,24, 18,30,57)
    r = Time.utc(2008,12, 1, 18,30,57).ago(1, :weeks)
    r.assert == e
  end

  unit :ago => "change days" do
    e = Time.utc(2008,11,30, 18,30,57)
    r = Time.utc(2008,12, 1, 18,30,57).ago(1, :days)
    r.assert == e
  end

  unit :ago => "change hours" do
    e = Time.utc(2008,11,30, 23,30,57)
    r = Time.utc(2008,12, 1,  0,30,57).ago(1, :hours)
    r.assert == e
  end

  unit :ago => "change minutes" do
    e = Time.utc(2008,11,30, 23,58,57)
    r = Time.utc(2008,12, 1,  0, 0,57).ago(2, :minutes)
    r.assert == e
  end

  unit :ago => "change seconds" do
    e = Time.utc(2008,11,30, 23,59,57)
    r = Time.utc(2008,12, 1,  0, 0, 1).ago(4, :seconds)
    r.assert == e
  end

  context "Months are the tricky one, so they get their own section"

  unit :ago => "change month no year wrap" do
    e = Time.utc(2008,11, 1)
    r = Time.utc(2008,12, 1).ago(1, :months)
    r.assert == e
  end

  unit :ago => "change month with year wrap due to month" do
    e = Time.utc(2007,12, 1)
    r = Time.utc(2008, 1, 1).ago(1, :months)
    r.assert == e
  end

  unit :ago => "change month with 12 or more converts extra months into a year adjustment" do
    e = Time.utc(2007, 1, 1)
    r = Time.utc(2008, 1, 1).ago(12, :months)
    r.assert == e

    e = Time.utc(2006,11, 1)
    r = Time.utc(2008,12, 1).ago(25, :months)
    r.assert == e
  end

  # 13 months = 1 year + 1 month AND month changing from 12 to 1 when going backward means go back 1 extra  year
  unit :ago => "change month with 12 or more AND year wrap due to month" do
    e = Time.utc(2006,12, 1)
    r = Time.utc(2008, 1, 1).ago(13, :months)
    r.assert == e
  end

  unit :ago => "smaller units should remain unchanged" do
    e = Time.utc(2005, 8,20, 15,37,59)
    r = Time.utc(2006, 1,20, 15,37,59).ago(5, :months)
    r.assert == e
  end

  unit :ago => "passing a negative number to ago should be same as a positive number to hence" do
    e = Time.utc(2008, 1, 1)
    r = Time.utc(2006,12, 1).ago(-13, :months)
    r.assert == e

    r = Time.utc(2006,12, 1).hence(13, :months)
    r.assert == e
  end

end

