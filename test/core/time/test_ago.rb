covers 'facets/time/ago'

test_case Time do

  # We do not need to test #ago b/c it is an alias for #less.
  # One test is provided to add to coverage report.
  method :ago do

    test "is an alias of #less" do
      t = Time.utc(2010,01,20,12,00,00)
      t.ago(1, :year).year.assert = 2009
      t.ago(2, :years).year.assert = 2008
    end

  end

end

