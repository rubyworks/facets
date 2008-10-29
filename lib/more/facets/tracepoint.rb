# = TracePoint
#
# A TracePoint is a Binding with the addition event information.
# And it's a better way to use set_trace_func.
#
# A TracePoint is a Binding with the addition of event information.
# Among other things, it functions very well as the join-point for
# Event-based AOP.
#
# == Usage
#
#   TracePoint.trace { |tp|
#     puts "#{tp.self.class}\t#{tp.called}\t#{tp.event}\t#{tp.return?}\t#{tp.back == tp.bind}"
#   }
#
#   1 + 1
#
# produces
#
#   Class   trace   return     true    false
#   Object          line       false   false
#   Fixnum  +       c-call     false   false
#   Fixnum  +       c-return   false   false
#
# == Notes
#
# You can't subclass Binding, so we delegate (which is better anyway).
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2005 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/binding'

# = CodePoint
#
# This is the same as a Binding. Not really needed, but I like consistency :)

CodePoint = Binding

# = TracePoint
#
# A TracePoint is a Binding with the addition of event information.
# Among other things, it functions very well as the join-point for
# Event-based AOP.
#
# == Usage
#
#   TracePoint.trace { |tp|
#     puts "#{tp.self.class}\t#{tp.called}\t#{tp.event}\t#{tp.return?}\t#{tp.back == tp.bind}"
#   }
#
#   1 + 1
#
# produces
#
#   Class   trace   return     true    false
#   Object          line       false   false
#   Fixnum  +       c-call     false   false
#   Fixnum  +       c-return   false   false
#
# == Notes
#
# You can't subclass Binding, so we delegate (which is better anyway).

class TracePoint  #< Codepoint

  # -- class ---------------------
  class << self

    @@active = false

    def active ; @@active ; end

    def active=(x)
      @@active = x ? true : false
      unless @@active
        set_trace_func nil
      end
    end

    # Trace execution using a TracePoint.
    def trace # :yield:
      if active
        bb_stack = []
        set_trace_func proc{ |e, f, l, m, b, k|
          #(p e, f, l, m, b, k, @@bb_stack; puts "---") if $DEBUG
          if ['call','c-call','class'].include?(e)
            bb_stack << b
          elsif ['return','c-return','end'].include?(e)
            bb = bb_stack.pop
          end
          b = bb if ! b    # this sucks!
          tp = TracePoint.new(e,m,b,bb)
          yield(tp)
        }
      end
    end

  end #class

  # -- instance -------------------

  attr_accessor :event, :binding, :back_binding

  # Until Ruby has a built-in way to get the name of the calling method
  # that information must be passed into the TracePoint.
  def initialize( event, method, bind, back_binding=bind )
    @event = event
    @method = method
    @binding = bind
    @back_binding = back_binding
  end

  # shorthand for binding
  def bind ; @binding ; end

  # shorthand for back_binding
  def back ; @back_binding ; end

  # Delegates "self" to the binding which
  # in turn delegates the binding object.
  def self ; @binding.self ; end

  # Returns the name of the event's method.
  # This could delegate to the binding if Ruby had
  # an internal way to retrieve the current method name.
  def callee ; @method ; end
  #def method ; @method ; end            # TODO Conflict with Kernel#method?
  alias_method( :called, :callee )       # TODO deprecate
  alias_method( :method_name, :called )  # TODO deprecate

  # delegate to binding
  #def method_missing(meth, *args, &blk)
  #  @binding.send(meth, *args, &blk)
  #end

  ### methods for working with events

  EVENT_MAP = {
    :all     => ['call', 'c-call', 'return', 'c-return', 'line', 'class', 'end', 'raise'],
    :before  => ['call', 'c-call'],
    :after   => ['return', 'c-return'],
    :call    => ['call'],
    :return  => ['return'],
    :ccall   => ['c-call'],
    :creturn => ['c-return'],
    :line    => ['line'],
    :class   => ['class'],
    :end     => ['end'],
    :raise   => ['raise']
  }
  def event_map(e) ; EVENT_MAP[e] ; end

  # Is the trace point defined or undefined?
  def event? ; !! @event ; end
  def eventless? ; ! @event ; end

  # For use in case conditions
  def ===(e)
    EVENT_MAP[e].include?(@event)
  end

  # Creates an <event>? method for each of the above event mappings.
  EVENT_MAP.each_pair { |m,v|
    define_method( "#{m}?" ){ v.include?(@event) }
  }

end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

# TODO

=begin #test

  # Note: TracePoint will probably prove tricky to test, since
  # manipulating set_trace_func tends to wreak havoc on errors,
  # the call stack, and so on.

  TracePoint.active = true

  TracePoint.trace { |tp|
    puts "#{tp.self.class}\t#{tp.called}\t#{tp.event}\t#{tp.return?}\t#{tp.back == tp.bind}"
  }

  1 + 1

=end
