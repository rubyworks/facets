module Kernel

  # Evaluate the block with +obj+ as self and return the block's value.
  # It is simply a more readable spelling of #instance_eval.
  #
  #   values = []
  #   with values do
  #     self << 'bar'
  #     self << 'baz'
  #   end
  #   values # => ['bar', 'baz']
  #
  # @deprecated Use obj.instance_eval { ... } instead. Rails 7.1 defines an
  #   unrelated Object#with that temporarily sets attributes, and this one
  #   silently replaces it. Scheduled for removal after 2027-09-30.
  #
  # @uncommon
  #   require 'facets/kernel/with'
  #
  def with(obj=self, &block)
    warn "Kernel#with is deprecated. Use obj.instance_eval { ... } instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    obj.instance_eval(&block)
  end

end
