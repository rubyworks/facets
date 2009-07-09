# = Class Extension
#
# Normally when including modules, class/module methods are not
# extended. To achieve this behavior requires some clever
# Ruby Karate. Instead class_extension provides an easy to use
# and clean solution. Simply place the extending class methods
# in a block of the special module method #class_extension.
#
#   module Mix
#     def inst_meth
#       puts 'inst_meth'
#     end
#
#     class_extension do
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
# == History
#
# Thanks to Trans, Nobu and Ulysses for their original on this concept.
#
# == Authors
#
# * Daniel Schierbeck
# * Thomas Sawyer
# * Nobu Nakada
# * Ulysses
#
# == Copying
#
# Copyright (c) 2006 Daniel Schierbeck
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

#
class Module

  alias_method :append_features_without_class_extension, :append_features

  # = class_extension
  #
  # Normally when including modules, class/module methods are not
  # extended. To achieve this behavior requires some clever
  # Ruby Karate. Instead class_extension provides an easy to use
  # and clean solution. Simply place the extending class methods
  # in a block of the special module method #class_extension.
  #
  #   module Mix
  #     def inst_meth
  #       puts 'inst_meth'
  #     end
  #
  #     class_extension do
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

  def class_extension(&block)
    @class_extension ||= Module.new do
      def self.append_features(mod)
        append_features_without_class_extension(mod)
      end
    end
    @class_extension.module_eval(&block) if block_given?
    @class_extension
  end

  private :class_extension

  def append_features(mod)
    append_features_without_class_extension(mod)
    mod.extend(class_extension)
    if mod.instance_of? Module
      mod.__send__(:class_extension).__send__(:include, class_extension)
    end
  end

end

class Class
  # For a class #class_extension is the same as class_eval.
  # The alternative is to "undef_method :class_extension",
  # but this seems uneccessarily limited.

  def class_extension(&blk)
    class_eval(&blk)
  end
end

