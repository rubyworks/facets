class Module

  private

  # Include module and apply module_fuction to the
  # included methods.
  #
  #   module Utils
  #     module_function
  #     def foo; "foo"; end
  #   end
  #
  #   module UtilsPlus
  #     include_function_module Utils
  #   end
  #
  #  CREDIT: Trans

  def include_function_module *mod
    include(*mod)
    module_function(*mod.collect{|m| m.private_instance_methods & m.methods(false)}.flatten)
  end

end

