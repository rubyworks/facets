module Enumerable
  
  # The same as #include?() but equality is tested using ===.
  # 
  #   [1, 2, "a"].has?(2)       #=> true
  #   [1, 2, "a"].has?(String)  #=> true
  #   [1, 2, "a"].has?(3)       #=> false
  # 
  def has?(what)
    any? { |x| what === x }
  end
  
  alias have? has?
  
end
