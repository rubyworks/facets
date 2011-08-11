covers 'facets/time/future'

test_case Time do

  method :future? do

    test do
      t = Time.now + 1000
      t.assert.future?
    end

    test do
      n = Time.now - 1000
      n.refute.future?
    end

    test do
      n = Time.now + 1001
      t = Time.now + 1000
      n.assert.future?(t)
    end

    test do
      n = Time.now + 999
      t = Time.now + 1000
      n.refute.future?(t)
    end

  end

end

