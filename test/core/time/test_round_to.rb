covers 'facets/time/round_to'

test_case Time do

  method :round_to do

    setup do
      @t = Time.local(2000,03,03,3,37,23)
    end

    test "hour" do
      @t.round_to(60 * 60).assert == Time.local(2000,03,03,4, 0)
    end

    #test "month" do
    #  @t.round_to(1.month).assert == Time.local(2000,03,03,3, 0)
    #end

    test "15 minutes" do
      @t.round_to(15 * 60).assert == Time.local(2000,03,03,3,30)
    end

    test "10 minutes" do
      @t.round_to(10 * 60).assert == Time.local(2000,03,03,3,40)
    end

    test "5 minutes" do
      @t.round_to(5 * 60).assert == Time.local(2000,03,03,3,35)
    end

  end
  
end

