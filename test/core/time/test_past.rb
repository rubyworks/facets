covers 'facets/time/past'

test_case Time do

  method :past? do

    test do
      t = Time.now - 1000
      t.assert.past?
    end

    test do
      n = Time.now + 1000
      n.refute.past?
    end

    test do
      n = Time.now - 1001
      t = Time.now - 1000
      n.assert.past?(t)
    end

    test do
      n = Time.now - 999
      t = Time.now - 1000
      n.refute.past?(t)
    end

  end

end

