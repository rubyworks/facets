covers 'facets/timer'

tests Timer do

  meta :time do
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

  unit :start => "out of time", :stop => "out to time" do
    t = Timer.new(1)
    expect TimeoutError do
      t.start
      sleep 2
      t.stop
    end
  end

  unit :start => "in time" do
    t = Timer.new(2)
    t.start
    sleep 1
    t.stop
  end

end



