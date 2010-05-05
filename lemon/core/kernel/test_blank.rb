Covers 'facets/kernel/blank'

Case Kernel do

  Unit :blank? do
    Object.new.refute.blank?
  end

end

Case NilClass do

  Unit :blank? do
    nil.assert.blank?
  end

end

Case FalseClass do

  Unit :blank? do
    false.assert.blank?
  end

end

Case TrueClass do

  Unit :blank? do
    true.refute.blank?
  end

end

Case Array do

  Unit :blank? do
    [ ].assert.blank?
    [1].refute.blank?
  end

end

Case Hash do

  Unit :blank? do
    {}.assert.blank?
    {:a=>1}.refute.blank?
  end

end

Case String do

  Unit :blank? do
    "xyz".refute.blank?
    "   ".assert.blank?
  end

end

Case Numeric do

  Unit :blank? do
    0.refute.blank?
    10.refute.blank?
    10.0.refute.blank?
  end

end

