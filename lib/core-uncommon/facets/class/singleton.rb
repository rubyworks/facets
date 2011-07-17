class Class 

  #
  def singleton? 
    ! ancestors.include?( self ) rescue false 
  end

end 
