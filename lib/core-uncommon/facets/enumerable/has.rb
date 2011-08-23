module Enumerable
  
  # The same as #include?() but equality is tested using ===.
  # 
  #   [1, 2, "a"].has?(2)       #=> true
  #   [1, 2, "a"].has?(String)  #=> true
  #   [1, 2, "a"].has?(3)       #=> false
  # 
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # TODO: Perhaps #matches? would be a better name?
  #
  # CREDIT: Lavir the Whiolet
  def has?(what)
    any? { |x| what === x }
  end
  
  # Alias for #has?
  alias have? has?
  
end
