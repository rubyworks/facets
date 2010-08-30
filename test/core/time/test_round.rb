covers 'facets/time/round'

testcase Time do

  t = Time.local(2000,03,03,3,37,23)

  unit :round => "hour" do
    t.round(60 * 60).assert == Time.local(2000,03,03,4, 0)
  end

  #unit :round => "month" do
  #  t.round(1.month).assert == Time.local(2000,03,03,3, 0)
  #end

  unit :round => "15 minutes" do
    t.round(15 * 60).assert == Time.local(2000,03,03,3,30)
  end

  unit :round => "10 minutes" do
    t.round(10 * 60).assert == Time.local(2000,03,03,3,40)
  end

  unit :round => "5 minutes" do
    t.round( 5 * 60).assert == Time.local(2000,03,03,3,35)
  end
  
end

