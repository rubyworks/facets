covers 'facets/blank'

tests String do

  unit :blank? do
    "xyz".refute.blank?
    "   ".assert.blank?
  end

end
