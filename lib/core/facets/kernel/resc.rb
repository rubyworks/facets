module Kernel

  # Provides a shortcut to the Regexp.escape module method.
  #
  #   resc("H..LO")   #=> "H\\.\\.LO"
  #
  #   TODO: Should this be deprecated in favor of String#to_re/to_rx ?
  #
  #   CREDIT: Trans

  def resc(str)
    Regexp.escape(str.to_s)
  end

end

