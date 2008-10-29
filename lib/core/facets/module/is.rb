class Module

  # Is a given class or module an ancestor of this
  # class or module?
  #
  #  class X ; end
  #  class Y < X ; end
  #
  #   Y.is?(X)  #=> true
  #
  #   CREDIT: Trans

  def is?(base)
    ancestors.slice(1..-1).include?(base)
  end

  # An alias for #include.
  #
  #   class X
  #     is Enumerable
  #   end
  #
  #   CREDIT: Trans

  #alias_method :is, :include

  def is(*mods)
    mods.each do |mod|
      if mod.const_defined?(:Self)
        extend mod::Self
        # pass it along if module
        if instance_of?(Module)
          const_set(:Self, Module.new) unless const_defined?(:Self)
          const_get(:Self).send(:include, mod::Self)
        end
      end
    end
    include(*mods)
  end

  # Expirmental idea for #is.
  #
  # If the module has #append_function_function
  # defined, this will use that instead of #include.
  #
  #   def is(*modules)
  #     module.each do { |m|
  #       if m.respond_to?(:append_feature_function)
  #         send(m.append_feature_function,m)
  #       else
  #         include m
  #       end
  #     end
  #   end

end

