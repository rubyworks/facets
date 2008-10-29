# = Infinity
#
# A full featured Infinity class, supporting signed direction.
# Inifinty is a multiton based on direction The constant INFINITY
# is provided as the common case with direction=+1 (positive).
#
# Besides being an class, these four constants are preset:
#
#   NaN
#   Inf
#   PosInf
#   NegInf
#
# These four constants a built from two other basic constants:
#
#   UNDEFINED
#   INFINITY
#
# In physical memory there are actually only three objects, namely
# three instances of InfinityClass, one for NaN, PosInf and NegInf,
# respectively.
#
# == Copying
#
# Copyright (c) 2004 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.
#
# == Authors
#
# * Thomas Sawyer
#
# == Todo
#
# * Could @direction values greater than 1 support Aleph?

require 'facets/multiton'

# = Infinity
#
# A full featured Infinity class, supporting signed direction.
# Inifinty is a multiton based on direction The constant INFINITY
# is provided as the common case with direction=+1 (positive).
#
# Besides being an class, these four constants are preset:
#
#   NaN
#   Inf
#   PosInf
#   NegInf
#
# These four constants a built from two other basic constants:
#
#   UNDEFINED
#   INFINITY
#
# In physical memory there are actually only three objects, namely
# three instances of InfinityClass, one for NaN, PosInf and NegInf,
# respectively.
#
class InfinityClass < Numeric
  include Multiton

  attr_reader :direction

  def initialize(direction=1)
    @direction = (direction <=> 0)
    super()
  end

  # Change direction of infinity.

  def -@
    case @direction
    when  0 : self.class.instance(0)
    when  1 : self.class.instance(-1)
    when -1 : self.class.instance(1)
    end
  end

  # Noop.

  def +@
    self
  end

  # Convert to the float version of infinity.

  def to_f
    (1.0/0) * @direction
  end

  # Gee, a real infinite loop!

  def times
    loop do yield end
  end

  # Coerce allows other numbers to be
  # compared to infinity.

  def coerce(other)
    case other
    when InfinityClass
      super
    else
      return -self, other
    end
  end

  # Equality. Note that NaN != NaN.

  def ==(other)
    case other
    when InfinityClass
      if @direction == 0 and other.direction == 0
        false
      else
        super
      end
    else
      false
    end
  end

  # Comparision where infinity is alway greatest
  # and negative infinityalways least.

  def <=>(other)
    case other
    when InfinityClass
      @direction <=> other.direction
    else
      @direction
    end
  end

  #

  def to_s
    case @direction
    when  0  : "NaN"
    when  1  : "PosInf"
    when -1  : "NegInf"
    end
  end

end

#

class Numeric

  def finite?
    not InfinityClass === self
  end

  def infinite?
    return false if NaN == self
    InfinityClass === self
  end
  alias :inf? :infinite?

  def nan?
    NaN == self
  end

  def posinf?
    PosInf == self
  end

  def neginf?
    NegInf == self
  end

end

# Set constant to positive infinity.
UNDEFINED = InfinityClass.new(0)
INFINITY  = InfinityClass.new(1)

NaN = UNDEFINED
Inf = INFINITY
PosInf = +INFINITY
NegInf = -INFINITY

