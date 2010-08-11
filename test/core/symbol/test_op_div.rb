covers 'facets/symbol/op_div'

testcase Symbol do

  unit :/ do
    (:merb / "string").assert == "merb/string"
    (:merb / :symbol).assert == "merb/symbol"
  end

end

