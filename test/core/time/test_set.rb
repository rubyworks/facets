covers 'facets/time/set'

tests Time do

  setup do
    Time.utc(2010,10,01,12,15,0)
  end

  unit :set => 'year' do |t|
    x = t.set(:year=>2020)
    x.year.assert == 2020
  end

  unit :set => 'month' do |t|
    x = t.set(:month=>11)
    x.month.assert == 11
  end

  unit :set => 'day' do |t|
    x = t.set(:day=>15)
    x.day.assert == 15
  end

  unit :set => 'hours' do |t|
    x = t.set(:hour=>12)
    t.hour.assert == 12
  end

  unit :set => 'minutes' do |t|
    x = t.set(:minutes=>12)
    x.min.assert == 12
  end

  unit :set => 'seconds' do |t|
    x = t.set(:seconds=>9)
    x.sec.assert == 9
  end

end
