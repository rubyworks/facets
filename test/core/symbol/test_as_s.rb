covers 'facets/symbol/as_s'

testcase Symbol do

  unit :as_s do
    s = :foo.as_s.sub('f','g')
    s.assert == :goo
  end

end

