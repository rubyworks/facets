module Kernel

  # Anything that can be marshaled can be copied in totality.
  #
  #   "ABC".deep_copy  #=> "ABC"
  #
  # NOTE: Not sure why we wouldn't just call this #copy, but
  # the term +deep_copy+ seems to be the common practive.
  def deep_copy
    Marshal::load(Marshal::dump(self))
  end

end

