
covers 'facets/date/cmp'

test_case Time do

  method :<=> do

    test "equivalent" do
      time = Time.gm(2000) # 2000-01-01 00:00:00 UTC
      date = time.to_date
      datetime = time.to_datetime
      
      (time <=> date).assert == 0
      (time <=> datetime).assert == 0
      
      (date <=> datetime).assert == 0
      (date <=> time).assert == 0
      
      (datetime <=> time).assert == 0
      (datetime <=> date).assert == 0
    end

    test "different" do
      today = Date.today
      yesterday = today - 1
      
      (today <=> yesterday).assert == 1
      (yesterday <=> today).assert == -1
      
      (today <=> yesterday.to_datetime).assert == 1
      (today <=> yesterday.to_time).assert == 1
      
      (today.to_time <=> yesterday.to_datetime).assert == 1
      (today.to_time <=> yesterday.to_time).assert == 1
    end
  end

end
