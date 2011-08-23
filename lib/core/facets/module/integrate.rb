require 'facets/module/redirect_method'
require 'facets/module/redefine_method'
require 'facets/module/rename_method'
require 'facets/module/wrap_method'
require 'facets/module/nodef'

class Module

  # Using integrate is just like using include except the
  # module included is a reconstruction of the one given
  # altered by the commands given in the block.
  #
  # Convenient commands available are: #rename, #redef,
  # #remove, #nodef and #wrap. But any module method
  # can be used.
  #
  #   module IntegrateExampleModule
  #     def q ; "q" ; end
  #     def y ; "y" ; end
  #   end
  #
  #   class InegrateExampleClass
  #     integrate IntegrateExampleModule do
  #       undef_method :y
  #     end
  #   end
  #
  #   x = InegrateExampleClass.new
  #   x.q  #=> "q"
  #
  #   expect NameError do
  #     x.y
  #   end
  #
  # This is like #revisal, but #revisal only
  # returns the reconstructred module. It does not
  # include it.
  #
  # CREDIT: Trans

  def integrate(mod, &block)
    #include mod.revisal( &blk )
    m = Module.new{ include mod }
    m.class_eval(&block)
    include m
  end

end

