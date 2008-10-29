require 'facets/functor'

module Kernel

  # Provides access to an object's metaclass (ie. singleton)
  # by-passsing access provisions. So for example:
  #
  #   class X
  #     meta.attr_accesser :a
  #   end
  #
  #   X.a = 1
  #   X.a #=> 1
  #
  # The fact that some class methods are private and thus inaccessable
  # via use of metaclass, is really a problem with them being private --which
  # is probably not really neccessary. Short of making them public though, thiere
  # is this method or one could use the #instance functor.
  #
  # TODO: Don't see any reason this can't go into core, but there is
  # a conflict with URI prior to 1.8.6, so it will have to wait.
  #
  #  CREDIT: Trans

  def meta
    @_meta_functor ||= Functor.new do |op,*args|
      (class << self; self; end).send(op,*args)
    end
  end

end

