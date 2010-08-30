covers 'facets/time/future'

testcase Time do

  #
  unit :future? do
    t = Time.now + 1000
    t.assert.future?

    n = Time.now - 1000
    n.refute.future?

    n = Time.now + 1001
    n.assert.future?(t)

    n = Time.now + 999
    n.refute.future?(t)
  end

end

