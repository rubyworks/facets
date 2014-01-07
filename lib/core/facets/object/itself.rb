class Object

  # An identity method that provides access to an object's 'self'.
  #
  # Example
  #
  #   [1,2,3,4,5,1,2,2,3].group_by(&:itself)
  #   #=> {1=>[1, 1], 2=>[2, 2, 2], 3=>[3, 3], 4=>[4], 5=>[5]}
  #
  # CREDIT: Michael Kohl

  def itself
    self
  end

end
