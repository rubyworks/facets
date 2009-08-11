module Kernel

  # Outputs the file, line and current method.
  #
  #   caller(1).first
  #   "/usr/lib/ruby/1.8/irb/workspace.rb:52:in `irb_binding'"
  #
  # CREDIT: William Mason
  def __HERE__
    caller(1).first
  end

end

