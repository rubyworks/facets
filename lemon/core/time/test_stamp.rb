require 'facets/time.rb'
require 'time' # for parse method

Case Time do

  # TODO: Problem with TIMEZONE.
  #Unit :stamp do
  #  t = Time.parse('4/20/2005 15:37')
  #  t.stamp.assert == "Wed Apr 20 15:37:00 PDT 2005"
  #end

  Unit :stamp => "long format" do
    t = Time.parse('2005-04-20 15:37')
    t.stamp(:long).assert == "April 20, 2005 15:37"
  end

  Unit :stamp => "short format" do
    t = Time.parse('2005-04-20 15:37')
    t.stamp(:short).assert == "20 Apr 15:37"
  end

end

