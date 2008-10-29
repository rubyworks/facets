module Kernel

  # Anything that can be marshaled can be copied in totality.
  # This is also commonly called a deep_copy.
  #
  #   "ABC".copy  #=> "ABC"
  #
  def deep_copy
    Marshal::load(Marshal::dump(self))
  end

end

