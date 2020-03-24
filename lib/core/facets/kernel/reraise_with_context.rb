# Moved to lib/core/facets/exception/reraise_with_context.rb
require 'facets/exception/add_context'

module Kernel
  # Rescues the given class of exceptions (defaults to Exception), adds the given context, and
  # re-raises with this additional context.
  #
  # This is especially useful inside a loop, allowing you to provide details about the specific
  # iteration where the error was encountered, so that your general-purpose error handler (possibly
  # at a much higher level in the app) can report to you
  #
  #   begin
  #     …
  #     users.each.with_index do |user, i|
  #       reraise_with_context(user: user, i: i) do
  #         send_reminder_email(user)
  #       end
  #     end
  #
  #     User.find_each do |user|
  #       reraise_with_context(args: [user]) do
  #         send_reminder_email(user)
  #       end
  #     end
  #     …
  #   rescue
  #     # $!.context[:user], etc. is available here
  #     report_error $!, $!.context
  #   end
  #
  # See also: Enumerable#reraise_with_context, Exception.reraise_with_context
  #
  def reraise_with_context(exception_to_rescue = Exception, context)
    exception_to_rescue <= Exception or raise "expected exception_to_rescue to be an Exception class but was: #{exception_to_rescue.inspect}"
    context.is_a?(Hash) or raise "expected context to be a Hash but was: #{context.inspect}"
    begin
      yield
    rescue exception_to_rescue
      $!.add_context(context)
      raise
    end
  end
end
