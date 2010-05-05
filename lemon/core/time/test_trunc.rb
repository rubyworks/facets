Covers 'facets/time/trunc'

Case Time do

  t = Time.local(2000,03,03,3,37,23)

  Unit :trunc => "hour" do
    t.trunc(60 * 60).assert == Time.local(2000,03,03,3, 0)
  end

  #Unit :trunc => "month" do
  #  t.trunc(1.month).assert == Time.local(2000,03,01,0, 0)
  #end

  Unit :trunc => "15 minutes" do
    t.trunc(15 * 60).assert == Time.local(2000,03,03,3,30)
  end
  
  Unit :trunc => "10 minutes" do
    t.trunc(10 * 60).assert == Time.local(2000,03,03,3,30)
  end

  Unit :trunc => "05 minutes" do
    t.trunc(5 * 60).assert == Time.local(2000,03,03,3,35)
  end

end

