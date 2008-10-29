# = Clonable
#
# Standard basis for adding deep #dup and #clone to a class.
# Provides a class with deep cloneablity via the standard
# #dup and #clone methods.
#
# == Authors
#
# * Ken Bloom    (Current Version)
# * Jim Weirich  (Original Version)
#
# == History
#
# Cloneable was ported from Jim Weirich's Rake.
#
# == Todo
#
# * Is there a more robust means to determining if clone or dup is used?
#
# == Copying
#
# Copyright (c) 2007 Ken Bloom
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

# = Clonable
#
# Standard basis for adding deep #dup and #clone to a class.
# Provides a class with deep cloneablity via the standard
# #dup and #clone methods.
#
module Cloneable
  def initialize_copy(sibling)
    #first duplicate my superclass' state. Note that if it's duplicating
    #instance variables, this will be overwritten, but this is important
    #because we could be dealing with a C extension with state hidden from
    #the Ruby interpreter
    super

    #we want to know if we're being dup'ed or clone'd, because we want to
    #preserve the state of our internals the same way our state is being
    #preserved. (If we can't figure it out, we'll just use #dup.)
    operation=caller.find{|x| x !~ /'initialize_copy'/}.
      match(/`(dup|clone)'/)[1] or :dup

    sibling.instance_variables.each do |ivar|
      value = sibling.instance_variable_get(ivar)

      #set my instance variable to be a #dup or #clone
      #or my sibling, depending on what's happening to me right now
      instance_variable_set(ivar, value.send(operation))
    end
  end
end 

# OLD VERSION

#module Cloneable
#  def clone
#    sibling = self.class.new
#    instance_variables.each do |ivar|
#      value = self.instance_variable_get(ivar)
#      sibling.instance_variable_set(ivar, value.dup) #rake_dup)
#    end
#    sibling
#  end
#  alias_method :dup, :clone
#end

