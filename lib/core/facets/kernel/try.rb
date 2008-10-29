module Kernel

  # Try a method.
  #   @person ? @person.name : nil
  # vs
  #   @person.try(:name)
  #
  #  CREDIT: Chris Wanstrath

  def try(method, default=nil)
    if respond_to? method
      send method 
    else
      default
    end
  end

end




 
