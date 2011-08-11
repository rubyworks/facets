covers 'facets/time/trunc'

test_case Time do

  method :trunc do

    setup do
      @t = Time.local(2000,03,03,3,37,23)
    end

    test "hour" do
      @t.trunc(60 * 60).assert == Time.local(2000,03,03,3, 0)
    end

    #test "month" do
    #  @t.trunc(1.month).assert == Time.local(2000,03,01,0, 0)
    #end

    test "15 minutes" do
      @t.trunc(15 * 60).assert == Time.local(2000,03,03,3,30)
    end
    
    test "10 minutes" do
      @t.trunc(10 * 60).assert == Time.local(2000,03,03,3,30)
    end

    test "05 minutes" do
      @t.trunc(5 * 60).assert == Time.local(2000,03,03,3,35)
    end

  end

end

