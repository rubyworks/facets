class Exception
  attr_reader :context

  def add_context(context)
    @context ||= {}
    context.is_a?(Hash) or raise "expected context to be a Hash but was: #{context.inspect}"
    @context.merge!(context)
  end
end
