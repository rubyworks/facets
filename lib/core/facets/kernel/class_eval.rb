require 'facets/kernel/singleton_class'

module Kernel

  # Calling #class_eval on an object acts just like
  # <tt>singleton_class.class_eval</tt>.
  def class_eval(*args, &block)
    singleton_class.class_eval(*args, &block)
  end

end
