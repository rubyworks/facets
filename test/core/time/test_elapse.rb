covers 'facets/time/elapse'

testcase Time do

  metaunit :elapse do
    t = Time.elapse { sleep 1 }
    assert( (t > 0.9) && (t < 2.1 ))
  end

end

