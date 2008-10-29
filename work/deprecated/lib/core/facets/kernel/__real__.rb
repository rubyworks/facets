# = TODO:
#
#   - Probably get rid of __self__ or get a new name.
#     It is similar to #meta + #as, but just for Object/Kernel.

require 'facets/functor'

module Kernel

  # Returns a Functor that allows one to call any
  # Kernel or Object method bound to self, making it
  # possible to bypass overrides of Kernel and Object
  # methods.
  #
  #   class A
  #     def object_id ; "OBTUSE" ; end
  #   end
  #
  #   c = C.new
  #   c.object_id         #=> "OBTUSE"
  #   c.__real__.object_id    #=> 6664875832
  #
  # NOTE: This has been through a couple of renamings,
  # including #__object__, #__self__, and #self.

  def __real__
    @__real__ ||= Functor.new do |meth, *args|  # &blk|
      Object.instance_method(meth).bind(self).call(*args) # ,&blk)
    end
  end

  #--
  #   def as( role, &blk )
  #     unless role.is_a?(Class)
  #       role = self.class.const_get( role )
  #     end
  #     @roles ||= {}
  #     @roles[role] ||= role.allocate
  #     robj = @roles[role]
  #     robj.assign_from( self )
  #     result = robj.instance_eval( &blk )
  #     self.assign_from( robj )  # w/o this much like namespaces
  #     result
  #   end
  #++

end

