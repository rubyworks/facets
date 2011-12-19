class Class 

  # Return true if a class is the singleton class of
  # an object.
  #
  # @non-core
  #   require 'facets/class/singleton'
  #
  def singleton? 
    ! ancestors.include?( self ) rescue false 
  end

end 
