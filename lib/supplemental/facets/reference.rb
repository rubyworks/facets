# = Reference
#
# Reference provides a way to access object indirectly.
# This allows for the object itself to be changed on the fly.
#
# == Synopsis
#
#   a = "HELLO"
#   b = ref(a)
#   b.to_s    #=> "HELLO"
#   c = 10
#   b.become(c)
#   b.to_s    #=> "10"
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

# = Reference
#
# Reference provides a way to access object indirectly.
# This allows for the object itself to be changed on the fly.
#
#   a = "HELLO"
#   b = ref(a)
#   b.to_s    #=> "HELLO"
#   c = 10
#   b.become(c)
#   b.to_s    #=> "10"
#
# TODO: Use BasicObject for Ruby 1.9.

class Reference #< BasicObject

  # Privatize most Kernel methods.
  private *instance_methods

  def self.new(obj)
    ref = allocate
    ref.become obj
    ref
  end

  def method_missing(*args, &block)
    @ref.__send__(*args, &block)
  end

  def become(obj)
    old = @ref
    @ref = obj
    old
  end

  def __value__
    @ref
  end

  alias_method :instance_delegate, :__value__
end


module Kernel

  # Shortcut reference constructor.
  def ref(x)
    Reference.new(x)
  end

end

