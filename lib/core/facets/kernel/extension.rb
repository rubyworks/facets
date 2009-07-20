module Kernel

  # Don't say it!
  def extension
    class << self; self; end
  end

end

