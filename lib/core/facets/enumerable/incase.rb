module Enumerable
  
  # The same as #include? but tested using #=== instead of #==.
  # 
  #   [1, 2, "a"].incase?(2)       #=> true
  #   [1, 2, "a"].incase?(String)  #=> true
  #   [1, 2, "a"].incase?(3)       #=> false
  #
  # Why the name `incase`? Because the method uses case-equality.
  # Along with the alliteration for "in case" and the similarity
  # with "include?", it seemed like the perfect fit.
  #
  # @author Lavir the Whiolet
  #
  def incase?(what)
    any? { |x| what === x }
  end

end
