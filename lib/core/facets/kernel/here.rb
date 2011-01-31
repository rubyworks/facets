module Kernel

  # A shorthand pronoun for binding().
  #
  #   a = 3
  #   eval("a", here)  #=> 3
  #
  alias_method :here, :binding

end

