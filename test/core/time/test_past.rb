covers 'facets/time/past'

testcase Time do

  #
  unit :past? do
    t = Time.now - 1000
    t.assert.past?

    n = Time.now + 1000
    n.refute.past?

    n = Time.now - 1001
    n.assert.past?(t)

    n = Time.now - 999
    n.refute.past?(t)
  end

end

