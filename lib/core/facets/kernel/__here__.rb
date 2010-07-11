module Kernel

  # Returns the file, line and current method.
  #
  #   __HERE__ #=> caller(0).first
  #
  # CREDIT: William Mason
  def __HERE__
    caller(1).first
  end

end

