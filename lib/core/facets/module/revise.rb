require 'facets/module/redirect_method'
require 'facets/module/redefine_method'
require 'facets/module/rename_method'
require 'facets/module/wrap_method'

class Module

  # Return a new module based on another.
  # This includes the original module into the new one.
  #
  #  CREDIT: Trans

  def revise(&blk)
    base = self
    nm = Module.new{ include base }
    nm.class_eval(&blk)
    nm
  end

  alias_method :revisal, :revise

  # Using integrate is just like using include except the
  # module included is a reconstruction of the one given
  # altered by the commands given in the block.
  #
  # Convenient commands available are: #rename, #redef,
  # #remove, #nodef and #wrap. But any module method
  # can be used.
  #
  #   module W
  #     def q ; "q" ; end
  #     def y ; "y" ; end
  #   end
  #
  #   class X
  #     integrate W do
  #       nodef :y
  #     end
  #   end
  #
  #   x = X.new
  #   x.q  #=> "q"
  #   x.y  #=> missing method error
  #
  # This is like #revisal, but #revisal only
  # returns the reconstructred module. It does not
  # include it.
  #
  #  CREDIT: Trans

  def integrate(mod, &block)
    #include mod.revisal( &blk )
    m = Module.new{ include mod }
    m.class_eval(&block)
    include m
  end

  alias_method :remove, :remove_method
  alias_method :nodef,  :undef_method

end

