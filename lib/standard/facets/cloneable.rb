# Clonable provides a standard basis for adding deep cloneablity to a class
# via the standard #dup and #clone methods.
#
# Cloneable was originally ported from Jim Weirich's Rake.
# The current version is the work of Ken Bloom.
#
# DEPRECATED: A better approach is to provide a #deep_dup and and a #deep_clone,
# then if a class needs these for #dup and #clone they can just alias them.
#
# CREDIT: Ken Bloom

module Cloneable

  def initialize_copy(sibling)
    # First duplicate my superclass' state. Note that if it's duplicating
    # instance variables, this will be overwritten, but this is important
    # because we could be dealing with a C extension with state hidden from
    # the Ruby interpreter.
    super

    # We want to know if we're being dup'ed or clone'd, because we want to
    # preserve the state of our internals the same way our state is being
    # preserved. (If we can't figure it out, we'll just use #dup.)
    operation = (
      copy_call  = caller.find{|x| x !~ /'initialize_copy'/}
      copy_match = copy_call.match(/`(dup|clone)'/)
      copy_match ? copy_match[1] : :dup
    )

    sibling.instance_variables.each do |ivar|
      value = sibling.instance_variable_get(ivar)

      # Set my instance variable to be a #dup or #clone
      # or my sibling, depending on what's happening to me right now.
      instance_variable_set(ivar, value.send(operation))
    end
  end

  # TODO: Is there a more robust means of determining if clone or dup is used?
  #def clone
  #  @_copy_operation = :clone
  #  super
  #end
  #
  #def dup
  #  @_copy_operation = :dup
  #  super
  #end

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

