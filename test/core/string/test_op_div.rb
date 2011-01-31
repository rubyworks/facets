covers 'facets/string/op_div'

testcase String do

  unit :/ do
    ('merb' / 'string').assert == "merb/string"
    ('merb' / :symbol).assert == "merb/symbol"
  end

end

