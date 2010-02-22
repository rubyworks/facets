# = Boolean
#
# Stackable mixin provides #pop, #push, #pull, etc.
# It depends on #slice, #splice and #insert.
#
# == Notes
#
# * This was suggested by Ara T. Howard
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

require 'facets/kernel/true'
require 'facets/kernel/false'

module Kernel

  # Boolean conversion for not being nil or false.
  # Other classes may redefine this to suite the
  # particular need.
  #
  #   "abc".to_b   #=> true
  #   true.to_b    #=> true
  #   false.to_b   #=> false
  #   nil.to_b     #=> false
  #
  def to_b
    self ? true : false
  end

  # Returns true is an object is class TrueClass
  # or FalseClass, otherwise false.
  #
  #   true.bool?   #=> true
  #   false.bool?  #=> true
  #   nil.bool?    #=> false
  #
  def bool?
    (true == self or false == self)
  end

end


class Object
  def to_bool
    true
  end
end


class TrueClass
  def to_bool
    self
  end
end


class FalseClass
  def to_bool
    self
  end
end


class NilClass
  def to_bool
    false
  end
end


class String

  # Interpret common affirmative string meanings as true,
  # otherwise nil or false. Blank space and case are ignored.
  # The following strings that will return true:
  #
  #   true
  #   yes
  #   on
  #   t
  #   1
  #   y
  #   ==
  #
  # The following strings will return nil:
  #
  #   nil
  #   null
  #
  # All other strings return false.
  #
  # Examples:
  #
  #   "true".to_b   #=> true
  #   "yes".to_b    #=> true
  #   "no".to_b     #=> false
  #   "123".to_b    #=> false
  #
  def to_b
    case self.downcase.strip
    when 'true', 'yes', 'on', 't', '1', 'y', '=='
      return true
    when 'nil', 'null'
      return nil
    else
      return false
    end
  end

end


class Array

  # Boolean conversion for not empty?
  def to_b
    ! self.empty?
  end

end


class Numeric

  # Provides a boolean interpretation of self.
  # If self == 0 then false else true.
  #
  #   0.to_b    #=> false
  #   1.to_b    #=> true
  #   2.3.to_b  #=> true
  #
  def to_b
    self == 0 ? false : true
  end

end

