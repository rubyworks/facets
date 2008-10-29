# = Functor
#
# = Synopsis
#
# By definition a Functor is simply a first class method, but these are common
# in the form of Method and Proc. So for Ruby a Functor is a bit more specialized
# as a Higher-order function or Metafunction. Essentally, a Functor can vary
# its behavior accorrding to the operation applied to it.
#
#   f = Functor.new { |op, x| x.send(op, x) }
#   f + 1  #=> 2
#   f + 2  #=> 4
#   f + 3  #=> 6
#   f * 1  #=> 1
#   f * 2  #=> 4
#   f * 3  #=> 9
#
# == Author
#
# * Thomas Sawyer
#
# == History
#
# * 2006-11-04 trans Deprecated #functor_function, renamed to #to_proc.
# * 2006-11-04 trans All methods are now private except __ and #binding.
#
# == Todo
#
# * Consider renaming Functor to... ?
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


# By definition a Functor is simply a first class method, but these are common
# in the form of Method and Proc. So for Ruby a Functor is a more specialized
# as a Higher-order function or Metafunction. Essentally, a Functor can vary
# its behavior accorrding to the operation applied to it.
#
#   f = Functor.new { |op, x| x.send(op, x) }
#   f + 1  #=> 2
#   f + 2  #=> 4
#   f + 3  #=> 6
#   f * 1  #=> 1
#   f * 2  #=> 4
#   f * 3  #=> 9
#
class Functor

  # Privatize all methods except vital methods and #binding.
  private(*instance_methods.select { |m| m !~ /(^__|^binding$)/ })

  def initialize(&function)
    @function = function
  end

  def to_proc
    @function
  end

  # Any action against the functor is processesd by the function.
  def method_missing(op, *args, &blk)
    @function.call(op, *args, &blk)
  end

end

