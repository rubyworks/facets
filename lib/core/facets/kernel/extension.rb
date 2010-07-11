module Kernel

  # Don't say it!
  #
  # TODO: Must reduce the number of singlton method methods.
  #
  def extension
    class << self; self; end
  end

end

