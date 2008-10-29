# = Uninheritable
#
# Allows an object to declare itself as unable to be subclassed. The
# technique behind this is very simple (redefinition of #inherited), so this
# just provides an easier way to do the same thing with a consistent error
# message.
#
# == Usage
#
#   class A
#     extend Uninheritable
#   end
#
#   class B < A; end # => raises TypeError
#
# == AUTHORS
#
# * Austin Ziegler
#
# == COPYRIGHT
#
#   Copyright (c) 2003 Austin Ziegler
#
# == LICENSE
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#

# = Uninheritable
#
# Allows an object to declare itself as unable to be subclassed. The
# technique behind this is very simple (redefinition of #inherited), so this
# just provides an easier way to do the same thing with a consistent error
# message.
#
module Uninheritable
  # Redefines a class's #inherited definition to prevent subclassing of the
  # class extended by this module.
  def inherited(klass)
    raise TypeError, "Class #{self} cannot be subclassed."
  end
end

