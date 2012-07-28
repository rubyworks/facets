class Class 

  # Return true if a class is the singleton class of
  # an object.
  #
  # @uncommon
  #   require 'facets/class/singleton_class'
  #
  def singleton_class? 
    ! ancestors.include?( self ) rescue false 
  end

  # @deprecated
  alias :singleton? :singleton_class?

end 
