module Kernel

  # Don't say it!
  #
  # TODO: Must reduce the number of singleton method methods.
  #
  def extension
    class << self; self; end
  end

end

