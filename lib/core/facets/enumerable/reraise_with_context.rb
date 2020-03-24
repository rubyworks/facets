require 'facets/kernel/reraise_with_context'

module Enumerable

  # Returns an Enumerator that adds an exception handler that adds the value of each block argument
  # as context to any exceptions that are raised by that iteration.
  #
  # Example:
  #   User.find_each.reraise_with_context do |user|
  #     send_reminder_email(user)
  #   end
  #
  # See also: Kernel#reraise_with_context
  #
  def reraise_with_context
    return enum_for(__callee__) unless block_given?

    each do |*args|
      Kernel.reraise_with_context(args: args) do
        yield *args
      end
    end
  end
end

class Enumerator::Lazy
  # Lazy version of Enumerable#reraise_with_context
  #
  def reraise_with_context
    unless block_given?
      raise ArgumentError, "tried to call lazy #{__callee__} without a block"
    end

    lazy.map do |*args|
      Kernel.reraise_with_context(args: args) do
        yield *args
      end
    end
  end
end
