covers 'facets/time/round_to'

testcase Time do

  t = Time.local(2000,03,03,3,37,23)

  unit :round_to => "hour" do
    t.round_to(60 * 60).assert == Time.local(2000,03,03,4, 0)
  end

  #unit :round_to => "month" do
  #  t.round_to(1.month).assert == Time.local(2000,03,03,3, 0)
  #end

  unit :round_to => "15 minutes" do
    t.round_to(15 * 60).assert == Time.local(2000,03,03,3,30)
  end

  unit :round_to => "10 minutes" do
    t.round_to(10 * 60).assert == Time.local(2000,03,03,3,40)
  end

  unit :round_to => "5 minutes" do
    t.round_to(5 * 60).assert == Time.local(2000,03,03,3,35)
  end
  
end

