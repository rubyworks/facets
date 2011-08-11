covers 'facets/timer'

test_case Timer do

  class_method :time do
    test do
      Timer.time { |timer|
        timer.total_time.round.assert == 0
        sleep 1
        timer.total_time.round.assert == 1
        timer.stop
        timer.total_time.round.assert == 1
        sleep 1
        timer.total_time.round.assert == 1
        timer.start
        timer.total_time.round.assert == 1 
        sleep 1
        timer.total_time.round.assert == 2
      }
    end
  end

  method :start do
    test "out of time" do
      t = Timer.new(1)
      expect TimeoutError do
        t.start
        sleep 2
        t.stop
      end
    end

    test "in time" do
      t = Timer.new(2)
      t.start
      sleep 1
      t.stop
    end
  end

  method :stop do
    test "in time" do
      t = Timer.new(2)
      t.start
      sleep 1
      t.stop
    end
  end

end
