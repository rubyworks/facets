require 'facets/exception/add_context'

class Exception
  # Rescues the given exception (self), adds the given context, and re-raises
  #
  # See also: Kernel#reraise_with_context
  #
  def self.reraise_with_context(context)
    context.is_a?(Hash) or raise "expected context to be a Hash but was: #{context.inspect}"
    begin
      yield
    rescue self
      $!.add_context(context)
      raise
    end
  end
end

