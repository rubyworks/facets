covers 'facets/date'

tests Date do

  setup "Date 2005-05-20" do
    Date.civil(2005, 04, 20)
  end

  unit :to_date do |d|
    d.to_date.assert.instance_of?(::Date)
  end

  unit :to_time do |d|
    d.to_time.assert.instance_of?(::Time)
  end

  unit :to_s do |d|
    d.to_s.assert == "2005-04-20"
  end

  unit :stamp do |d|
    d.stamp.assert == "2005-04-20"
  end

  unit :stamp do |d|
    d.stamp(:short).assert == "20 Apr"
  end

  unit :stamp do |d|
    d.stamp(:long).assert == "April 20, 2005"
  end

  unit :days_in_month do |d|
    d.days_in_month.assert == 30
  end

  unit :days_of_month do |d|
    d.days_of_month.assert == (1..d.days_in_month).to_a
  end

end

tests String do

  unit :to_date do
    s = "2005-10-31"
    d = s.to_date
    d.day.assert == 31
    d.month.assert == 10
    d.year.assert == 2005
  end

end

tests Time do

  unit :to_date do
    t = Time.now #parse('4/20/2005 15:37')
    t.to_date.assert.instance_of?(::Date)
  end

end
