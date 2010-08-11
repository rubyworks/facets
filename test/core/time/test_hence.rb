covers 'facets/time/hence'

tests Time do

  # we don't need to hence b/c it is an alias for #in
  # one test is provided to add to coverage report

  unit :hence do
    e = Time.utc(2008,11, 1, 18,30,57)
    r = Time.utc(2007,11, 1, 18,30,57).hence(1, :years)
    r.assert == e                 
  end

end

