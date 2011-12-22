require 'facets/binding/eval'
require 'facets/kernel/__method__'

module Kernel

  # Global memo cache.
  $MEMO ||= {}

  # Memoize a method.
  # 
  #   class MemoExample
  #     attr_accessor :a
  #     def m
  #       memo{ @a }
  #     end
  #   end
  #
  #   ex = MemoExample.new
  #
  #   ex.a = 10
  #   ex.m  #=> 10
  #
  #   ex.a = 20
  #   ex.m  #=> 10
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/kernel/memo'
  #
  def memo(*args, &block)
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

