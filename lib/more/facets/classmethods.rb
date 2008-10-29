# = ClassMethods
#
# Miniframework provides a very convenient way to have modules
# pass along class methods in the inheritance chain.
#
# An oddity of Ruby, when including modules, class/module methods
# are not inherited. To achieve this behavior requires some clever
# Ruby Karate. Instead ClassMethods provides an easy to use and clean
# solution. Simply place the class inheritable methods in a block of
# the special module method #ClassMetods.
#
#   module Mix
#     def inst_meth
#       puts 'inst_meth'
#     end
#
#     class_methods do
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
# This is equivalent to the original (but still functional) techinique of
# putting the class/module methods in a nested ClassMethods module
# and extending the original module *manually*. Eg.
#
#   module Mix
#     def inst_meth
#       puts 'inst_meth'
#     end
#
#     module ClassMethods
#       def class_meth
#         "Class Method!"
#       end
#     end
#
#     extend ClassMethods
#   end
#
#   class X
#     include Mix
#   end
#
#   X.class_meth  #=> "Class Method!"
#
# Also note that #class_inherit is an available alias
# for #class_methods for the sake of backward compatability.
# And #class_extension is alias (potentially) looking forward
# to a future version on Ruby.
#
# == On Topic
#
# Just a quick comment on the need for this behavior.
#
# A module is an encapsulation of code, hence when a module is included
# (or extends), the module itself should have discretion over how it
# effects the receiving class/module. That is the very embodiment of
# encapsulation. Having it otherwise, as Ruby now does, stymies the
# practice --and we end up with "hacks", like this and ClassMethods,
# to compensate.
#
# Ruby would be much improved by making this bevaivor standard.
# And making non-inheritance the exception, which is alwasy easy
# enough to achieve: put the code in a separate (and thus uninherited)
# module.
#
# == Notes
#
# * There are currently two approaches to this, ClassMethods and class_extensions.
#   A third is being worked on called Component with the idea that a "component"
#   is like a module except that it's class-level methods are mixed-in as well.
#   This is an idea solution, however it is less that ideal to implement.
#
# == History
#
# Thanks to Nobu and Ulysses for their original work on this.
#
# == Authors
#
# * Nobu Nakada
# * Thomas Sawyer
# * Ulysses
#
# == Copying
#
# Copyright (c) 2005 Nobu Nakada, Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


# = ClassMethods
#
# ClassMethods provides an easy to use and clean
# solution. Simply place the class inheritable methods in a block of
# the special module method #ClassMetods.
#
#   module Mix
#     def inst_meth
#       puts 'inst_meth'
#     end
#
#     class_methods do
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
# This is equivalent to the original (but still functional) techinique of
# putting the class/module methods in a nested ClassMethods module
# and extending the original module *manually*. Eg.
#
#   module Mix
#     def inst_meth
#       puts 'inst_meth'
#     end
#
#     module ClassMethods
#       def class_meth
#         "Class Method!"
#       end
#     end
#
#     extend ClassMethods
#   end
#
#   class X
#     include Mix
#   end
#
#   X.class_meth  #=> "Class Method!"
#
# Also note that #class_inherit is an available alias
# for #class_methods for the sake of backward compatability.
# And #class_extension is alias (potentially) looking forward
# to a future version on Ruby.

class Module

  alias_method :append_features_without_classmethods, :append_features

  def append_features( base )
    result = append_features_without_classmethods( base )
    if const_defined?( :ClassMethods )
      base.extend( self::ClassMethods )
      unless base.is_a?( Class )
        unless base.const_defined?( :ClassMethods )
          base.const_set( :ClassMethods, Module.new )
        end
        my = self
        base::ClassMethods.class_eval do
          include my::ClassMethods
        end
      end
    end
    result
  end

  def class_methods( &yld )
    if const_defined?( :ClassMethods )
      self::ClassMethods.class_eval( &yld )
    else
      self.const_set( :ClassMethods, Module.new( &yld ) )
    end
    extend( self::ClassMethods )
    self::ClassMethods
  end

  # For compatibility with old rendition.
  alias_method :class_inherit, :class_methods

end

class Class
  undef_method :class_methods
  undef_method :class_inherit
end

