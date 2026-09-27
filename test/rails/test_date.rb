covers 'facets/date'

test_case Date do

  setup "Date 2005-05-20" do
    @d = Date.civil(2005, 04, 20)
  end

  method :to_date do
    test do
      @d.to_date.assert.instance_of?(::Date)
    end
  end

  method :to_time do
    test do
      @d.to_time.assert.instance_of?(::Time)
    end
  end

  method :to_s do
    test do
      @d.to_s.assert == "2005-04-20"
    end
  end

  method :stamp do
    test do
      @d.stamp.assert == "2005-04-20"
    end
  end

  method :stamp do
    test do
      @d.stamp(:short).assert == "20 Apr"
    end
  end

  method :stamp do
    test do
      @d.stamp(:long).assert == "April 20, 2005"
    end
  end

  method :days_in_month do
    test do
      @d.days_in_month.assert == 30
    end
  end

  method :days_of_month do
    test do
      @d.days_of_month.assert == (1..(@d.days_in_month)).to_a
    end
  end

end

test_case String do

  method :to_date do
    test do
      s = "2005-10-31"
      d = s.to_date
      d.day.assert == 31
      d.month.assert == 10
      d.year.assert == 2005
    end
  end

end

test_case Time do

  method :to_date do
    test do
      t = Time.now #parse('4/20/2005 15:37')
      t.to_date.assert.instance_of?(::Date)
    end
  end

end
