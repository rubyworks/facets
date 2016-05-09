covers 'facets/timer'

test_case Timer do

  class_method :time do
    test "can keep time of a block" do
      Timer.time do |timer|
        timer.total_time.round.assert == 0
        sleep 1
        timer.total_time.round.assert == 1
      end
    end

    test "can be stopped" do
      Timer.time do |timer|
        sleep 0.4
        timer.stop
        sleep 0.6
        timer.total_time.round.assert == 0
      end
    end

    test "timer can be started again" do
      Timer.time do |timer|
        timer.stop
        sleep 0.5
        timer.total_time.round.assert == 0
        timer.start
        sleep 1
        timer.total_time.round.assert == 1
      end
    end
  end

  method :start do
    test "out of time" do
      t = Timer.new(0.5)
      expect Timeout::Error do
        t.start
        sleep 1
        t.stop
      end
    end

    test "in time" do
      t = Timer.new(2)
      t.start
      sleep 0.5
      t.stop
    end
  end

  method :stop do
    test "in time" do
      t = Timer.new(2)
      t.start
      sleep 0.5
      t.stop
    end
  end

end
