require 'facets/time/elapse'

Case Time do

  Unit :elapse do
    #t = Time.parse('4/20/2006 15:37')
    t = Time.elapse { sleep 1 }
    assert( (t > 0.9) && (t < 2.1 ))
  end

end

