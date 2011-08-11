covers 'facets/time/elapse'

test_case Time do

  class_method :elapse do

    test do
      t = Time.elapse { sleep 1 }
      assert( (t > 0.9) && (t < 2.1 ))
    end

  end

end

