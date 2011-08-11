covers 'facets/time/set'

test_case Time do

  method :set do

    setup do
      @t = Time.utc(2010,10,01,12,15,0)
    end

    test 'year' do
      x = @t.set(:year=>2020)
      x.year.assert == 2020
    end

    test 'month' do
      x = @t.set(:month=>11)
      x.month.assert == 11
    end

    test 'day' do
      x = @t.set(:day=>15)
      x.day.assert == 15
    end

    test 'hours' do
      x = @t.set(:hour=>12)
      x.hour.assert == 12
    end

    test 'minutes' do
      x = @t.set(:minutes=>12)
      x.min.assert == 12
    end

    test 'seconds' do
      x = @t.set(:seconds=>9)
      x.sec.assert == 9
    end

  end

end
