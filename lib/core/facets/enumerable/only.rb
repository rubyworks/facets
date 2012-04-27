module Enumerable
  
  # Does this Enumerable have the only element?
  # 
  # It differs from Enumerable#one? in that it does not check the items
  # anyhow. It checks their quantity only.
  # 
  def only?
    each { |item| return true }
    return false
  end
  
end
