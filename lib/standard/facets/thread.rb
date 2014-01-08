# = Thread Related Extensions
#
# This a small colleciton of thread-related extensions.

require 'thread'

#require 'facets/binding/eval'
#require 'facets/kernel/__method__'

# This is the non-threaded form of #threaded_map_send.
require 'facets/enumerable/map_send'

module Kernel

  $MEMO_MUTEX = Mutex.new

  $MEMO ||= {}

  # Thead-safe instance-level memoization.
  # 
  #   class MemoExample
  #     attr_accessor :a
  #     def m
  #       safe_memo{ @a }
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
  def safe_memo(*args, &block)
    if args.empty?
      args = block.binding.eval('[self, __method__]')
    end
    $MEMO_MUTEX.synchronize do
      if $MEMO.key?(args)
        $MEMO[args]
      else
        $MEMO[args] = block.call
      end
    end
  end

end


module Enumerable

  # Like Enumerable#map but each iteration is processed via
  # a separate thread.
  #
  # CREDIT: Sean O'Halpin

  def threaded_map #:yield:
    map{ |e| Thread.new(e){ |t| yield(t) } }.map{ |t| t.value }
  end

  # Like Enumerable#map_send but each iteration is processed via
  # a separate thread.
  #
  # CREDIT: Sean O'Halpin

  def threaded_map_send(meth, *args, &block)
    map{ |e| Thread.new(e){ |t| t.send(meth, *args, &block) } }.map{ |t| t.value }
  end

end


module Kernel
  private

  # CREDIT: Zucker
  def sandbox(rescueblock_or_default=nil) #:yield:
    Thread.start do
      $SAFE = 4
      yield
    end.value
  rescue SecurityError => e
    if !rescueblock_or_default.nil?
      if rescueblock_or_default.is_a? Proc
        rescueblock_or_default.call e
      else
        rescueblock_or_default
      end
    else
      raise e
    end
  end

end

# Copyright (c) 2006 Sean O'Halpin, Thomas Sawyer
