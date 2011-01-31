class Module

  # Is a given class or module an ancestor of this
  # class or module?
  #
  #   class IsX ; end
  #   class IsY < IsX ; end
  #
  #   IsY.is?(IsX)  #=> true
  #
  # CREDIT: Trans

  def is?(base)
    Module===base && ancestors.slice(1..-1).include?(base)
  end

  # An alias for #include.
  #
  #   class IsExample
  #     is Enumerable
  #   end
  #
  # CREDIT: Trans

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

  #alias_method :is, :include

  # Expirmental idea for #is.
  #
  # If the module has #append_feature_function
  # defined, this will use that instead of #include ...
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

