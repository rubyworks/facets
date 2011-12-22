class Class 

  # Return true if a class is the singleton class of
  # an object.
  #
  # @uncommon
  #   require 'facets/class/singleton'
  #
  def singleton? 
    ! ancestors.include?( self ) rescue false 
  end

end 
