# = Recorder
#
# == Synopsis
#
# Recorder is similar essentially a method probe. It records everthing
# that happens to it, building an internal parse tree. You can then
# pass a substitute object and apply the recoding to it. Or you can
# utilize the parse tree.
#
# The only limitation of Recorder is with special operators, like if, &&, ||, etc.
# Since they are not true methods they can't be recorded. (Too bad for Ruby.)
#
# == Usage
#
#   class Z
#     def name ; 'George' ; end
#     def age ; 12 ; end
#   end
#
#   z = Z.new
#
#   r = Recorder.new
#   q = proc { |x| (x.name == 'George') & (x.age > 10) }
#   x = q[r]
#   x.__call__(z)
#
# produces
#
#   true
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/kernel/object_class'

# = Recorder
#
# Recorder is similar essentially a method probe. It records everthing
# that happens to it, building an internal parse tree. You can then
# pass a substitute object and apply the recoding to it. Or you can
# utilize the parse tree.
#
# The only limitation of Recorder is with special operators, like if, &&, ||, etc.
# Since they are not true methods they can't be recorded. (Too bad for Ruby.)
#
#   class Z
#     def name ; 'George' ; end
#     def age ; 12 ; end
#   end
#
#   z = Z.new
#
#   r = Recorder.new
#   q = proc { |x| (x.name == 'George') & (x.age > 10) }
#   x = q[r]
#   x.__call__(z)
#
# produces
#
#   true
#
class Recorder

  # Privatize all kernel methods.

  private(*instance_methods)

  #

  def initialize( msg=nil )
    @msg = msg
  end

  def inspect
    "<Recorder #{@msg.inspect}>"
  end

  def __call__( orig )
    return orig unless @msg

    sym  = @msg[0]
    args = @msg[1..-1].collect do |a|
      Recorder === a ? a.__call__(orig) : a
    end
    obj  = args.shift

    obj.__send__( sym, *args )
  end

  def method_missing( sym, *args, &blk )
    object_class.new( [ sym, self, *args ] )
  end

end

