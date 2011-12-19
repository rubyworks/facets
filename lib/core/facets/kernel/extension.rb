module Kernel

  # TODO: Must reduce the number of singleton method methods.

  # Don't say it!
  #
  def extension
    class << self; self; end
  end

end

