covers 'facets/time/in'

tests Time do

  instance "January 1st 2010 at Noon" do
    Time.utc(2010,01,01, 12,00,00)
  end

  unit :in => 'years' do |t|
    t.in(1, :year).year.assert = 2011
    t.in(2, :years).year.assert = 2012
  end

  unit :in => 'weeks' do |t|
    t.in(1, :week).day.assert == 8
    t.in(2, :weeks).day.assert == 15
  end

  unit :in => 'days' do |t|
    t.in(1, :day).day.assert == 2
    t.in(2, :days).day.assert == 3
  end

  unit :in => 'hours' do |t|
    t.in(1, :hour).hour.assert == 13
    t.in(2, :hours).hour.assert == 14
    t.in(12, :hours).hour.assert == 0
  end

  unit :in => 'minutes' do |t|
    t.in(1, :minute).min.assert == 1
    t.in(2, :minutes).min.assert == 2
    t.in(60, :minutes).min.assert == 0
  end

  unit :in => 'seconds' do |t|
    t.in(1, :second).sec.assert == 1
    t.in(2, :seconds).sec.assert == 2
    t.in(60, :seconds).sec.assert == 0
  end

  

  unit :in => "change_years" do
    e = Time.utc(2008,11, 1, 18,30,57)
    r = Time.utc(2007,11, 1, 18,30,57).in(1, :years)
    r.assert == e                 
  end

  unit :in => "change weeks" do
    e = Time.utc(2008,12, 1, 18,30,57)
    r = Time.utc(2008,11,24, 18,30,57).in(1, :weeks)
    r.assert == e
  end

  unit :in => "change days" do
    e = Time.utc(2008,12, 1, 18,30,57)
    r = Time.utc(2008,11,30, 18,30,57).in(1, :days)
    r.assert == e
  end

  unit :in => "change hours" do
    e = Time.utc(2008,12, 1,  0,30,57)
    r = Time.utc(2008,11,30, 23,30,57).in(1, :hours)
    r.assert == e
  end

  unit :in => "change minutes" do
    e = Time.utc(2008,12, 1,  0, 0,57)
    r = Time.utc(2008,11,30, 23,58,57).in(2, :minutes)
    r.assert == e
  end

  unit :in => "change seconds" do
    e = Time.utc(2008,12, 1,  0, 0, 1)
    r = Time.utc(2008,11,30, 23,59,57).in(4, :seconds)
    r.assert == e
  end


  concern "months are more difficult, so they get their own section"

  unit :in => "change month no year wrap" do
    e = Time.utc(2008,12, 1)
    r = Time.utc(2008,11, 1).in(1, :months)
    r.assert == e
  end

  unit :in => "change month with year wrap due to month" do
    e = Time.utc(2008, 1, 1)
    r = Time.utc(2007,12, 1).in(1, :months)
    r.assert == e
  end

  unit :in => "change month with 12 or more converts extra months into a year adjustment" do
    e = Time.utc(2008, 1, 1)
    r = Time.utc(2007, 1, 1).in(12, :months)
    r.assert == e

    e = Time.utc(2008,12, 1)
    r = Time.utc(2006,11, 1).in(25, :months)
    r.assert == e
  end

  unit :in => "change month with 12 or more AND year wrap due to month" do
    e = Time.utc(2008, 1, 1)
    r = Time.utc(2006,12, 1).in(13, :months)
    r.assert == e
  end

  unit :in => "smaller units should remain unchanged" do
    e = Time.utc(2006, 1,20, 15,37,59)
    r = Time.utc(2005, 8,20, 15,37,59).in(5, :months)
    r.assert == e
  end

  unit :in => "passing a negative number to #in should be same as a positive number to #ago" do
    e = Time.utc(2005, 8,20)
    r = Time.utc(2006, 1,20).in(-5, :months)
    r.assert == e

    r = Time.utc(2006, 1,20).ago(5, :months)
    r.assert == e
  end

end

