covers 'facets/time/less'

test_case Time do

  method :less do

    setup "January 20th 2010 at Noon" do
      @t = Time.utc(2010,01,20,12,00,00)
    end

    test 'years' do
      @t.less(1, :year).year.assert = 2009
      @t.less(2, :years).year.assert = 2008
    end

    test 'weeks' do
      @t.less(1, :week).day.assert == 13
      @t.less(2, :weeks).day.assert == 6
    end

    test 'days' do
      @t.less(1, :day).day.assert == 19
      @t.less(2, :days).day.assert == 18
    end

    test 'hours' do
      @t.less(1, :hour).hour.assert == 11
      @t.less(2, :hours).hour.assert == 10
      @t.less(12, :hours).hour.assert == 0
    end

    test 'minutes' do
      @t.less(1, :minute).min.assert == 59
      @t.less(2, :minutes).min.assert == 58
      @t.less(60, :minutes).min.assert == 0
    end

    test 'seconds' do
      @t.less(1, :second).sec.assert == 59
      @t.less(2, :seconds).sec.assert == 58
      @t.less(60, :seconds).sec.assert == 0
    end

  end

  method :less do

    concern "verify via dates"

    test "change years" do
      e = Time.utc(2007,11, 1, 18,30,57)
      r = Time.utc(2008,11, 1, 18,30,57).less(1, :years)
      r.assert == e
    end

    test "change weeks" do
      e = Time.utc(2008,11,24, 18,30,57)
      r = Time.utc(2008,12, 1, 18,30,57).less(1, :weeks)
      r.assert == e
    end

    test "change days" do
      e = Time.utc(2008,11,30, 18,30,57)
      r = Time.utc(2008,12, 1, 18,30,57).less(1, :days)
      r.assert == e
    end

    test "change hours" do
      e = Time.utc(2008,11,30, 23,30,57)
      r = Time.utc(2008,12, 1,  0,30,57).less(1, :hours)
      r.assert == e
    end

    test "change minutes" do
      e = Time.utc(2008,11,30, 23,58,57)
      r = Time.utc(2008,12, 1,  0, 0,57).less(2, :minutes)
      r.assert == e
    end

    test "change seconds" do
      e = Time.utc(2008,11,30, 23,59,57)
      r = Time.utc(2008,12, 1,  0, 0, 1).less(4, :seconds)
      r.assert == e
    end

  end

  method :less do

    concern "months do not have a fixed duration"

    test "change month no year wrap" do
      e = Time.utc(2008,11, 1)
      r = Time.utc(2008,12, 1).less(1, :months)
      r.assert == e
    end

    test "change month with year wrap due to month" do
      e = Time.utc(2007,12, 1)
      r = Time.utc(2008, 1, 1).less(1, :months)
      r.assert == e
    end

    test "change month with 12 or more converts extra months into a year adjustment" do
      e = Time.utc(2007, 1, 1)
      r = Time.utc(2008, 1, 1).less(12, :months)
      r.assert == e

      e = Time.utc(2006,11, 1)
      r = Time.utc(2008,12, 1).less(25, :months)
      r.assert == e
    end

    # 13 months = 1 year + 1 month AND month changing from 12 to 1,
    # when going backward, means going back 1 extra year.
    test "change month with 12 or more AND year wrap due to month" do
      e = Time.utc(2006,12, 1)
      r = Time.utc(2008, 1, 1).less(13, :months)
      r.assert == e
    end

    test "smaller units should remain unchanged" do
      e = Time.utc(2005, 8,20, 15,37,59)
      r = Time.utc(2006, 1,20, 15,37,59).less(5, :months)
      r.assert == e
    end

    test "passing a negative number to #less should be same as a positive number to #shift" do
      e = Time.utc(2008, 1, 1)
      r = Time.utc(2006,12, 1).less(-13, :months)
      r.assert == e

      r = Time.utc(2006,12, 1).shift(13, :months)
      r.assert == e
    end

  end

end
