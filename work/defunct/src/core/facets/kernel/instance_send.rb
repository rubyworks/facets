module Kernel

  # Private send.
  alias_method :instance_send, :__send__

end

