class Module

  # Normally when including modules, class/module methods are not
  # extended. To achieve this behavior requires some clever
  # Ruby Karate. Instead #class_extend provides an easy to use
  # and clean solution. Simply place the extending class methods
  # in a block of the special module method #class_extend.
  #
  #   module Mix
  #     def inst_meth
  #       puts 'inst_meth'
  #     end
  #
  #     class_extend do
  #       def class_meth
  #         "Class Method!"
  #       end
  #     end
  #   end
  #
  #   class X
  #     include Mix
  #   end
  #
  #   X.class_meth  #=> "Class Method!"
  #
  # NOTE: This old #class_extension version of this method
  # did not extend the containing class automatically --it had
  # to be done by hand. With #class_extend, that is no longer
  # the case.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Daniel Schierbeck, Thomas Sawyer
  #
  # THANKS: Nobu Nakada, Ulysses
  #
  # @uncommon
  #   require 'facets/module/class_extend'
  #
  def class_extend(*mods, &block)
    class_extension = Module.new

    class_extension.__send__(:include, *mods)
    class_extension.module_eval(&block) if block_given?

    extend(class_extension)  # extend this module too

    append_method = method(:append_features)

    (class << self; self; end).class_eval do
      define_method(:append_features) do |mod|
        append_method.call(mod)
        mod.extend(class_extension)
        if mod.instance_of?(Module)
          mod.__send__(:class_extend, class_extension)
        end
      end
    end

    class_extensions << class_extension
  end

  #private :class_extend

  #
  def class_extensions
    @class_extensions ||= []
  end

end

class Class

  # For Class, Module#class_extend is similar to class_eval.
  #
  # The alternative is to "undef_method :class_extend",
  # but this seems uneccessarily limited.
  #
  # @uncommon
  #   require 'facets/module/class_extend'
  #
  def class_extend(*mods, &block)
    class_extension = Module.new
    class_extension.__send__(:include, *mods)
    class_extension.module_eval(&block) if block
    extend(class_extension)
    class_extensions << class_extension
  end

end
