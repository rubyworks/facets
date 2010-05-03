require 'facets/symbol/chomp'

Case Symbol do

  Unit :chomp do
    :ab.chomp(:b).assert == :a
  end

  Unit :lchomp do
     :ab.lchomp(:a).assert == :b
  end

end

