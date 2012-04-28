module Enumerable
  
  # Returns the _only_ element in the enumerable.  Raises an IndexError if
  # the enumreable has more then one element.
  #
  #   [5].only      # => 5
  #
  #   expect IndexError do
  #     [1,2,3].only
  #   end
  #
  #   expect IndexError do
  #     [].only
  #   end
  #
  # CREDIT: Lavir the Whiolet, Gavin Sinclair, Noah Gibbs
  #
  def only
    each { |item| return item }
    raise IndexError, "not the only element of enumerable"
  end

  # Does this Enumerable have the only element?
  # 
  # It differs from Enumerable#one? in that it does not check the items.
  # themselves. It checks the quantity only.
  # 
  # CREDIT: Lavir the Whiolet
  #
  def only?
    each { |item| return true }
    return false
  end

end
