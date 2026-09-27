module Kernel

  # @deprecated Use Module#memoize instead, which provides proper
  #   per-object memoization without a global variable.
  #   Scheduled for removal after 2027-09-30.
  #
  # @uncommon
  #   require 'facets/kernel/memo'
  #
  def memo(*args, &block)
    warn "Kernel#memo is deprecated. Use Module#memoize instead. It will be removed after 2027-09-30.", uplevel: 1
    $MEMO ||= {}
    if args.empty?
      args = block.binding.eval('[self, __method__]')
    end
    if $MEMO.key?(args)
      $MEMO[args]
    else
      $MEMO[args] = block.call
    end
  end

end
