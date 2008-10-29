# = Annotation
#
# Annotations allows you to annontate objects, including methods with arbitrary
# "metadata". These annotations don't do anything in themselves. They are
# merely comments. But you can put them to use. For instance an attribute
# validator might check for an annotation called :valid and test against it.
#
# Annotation is an OpenObject, and is used across the board for keeping annotations.
#
# Annotation class serves for both simple and inherited cases depending on whether
# a base class is given.
#
#   class X
#     attr :a
#     ann :@a, :valid => lambda{ |x| x.is_a?(Integer) }
#
#     def validate
#       instance_variables.each { |iv|
#         if validator = self.class.ann(iv)[:valid]
#           value = instance_variable_get(iv)
#           unless validator.call(vale)
#             raise "Invalid value #{value} for #{iv}"
#           end
#         end
#       }
#     end
#
#   end
#
# == Authors
#
# * Thomas Sawyer
# * George Moschovitis
#
# == History
#
# * 2006-11-07 trans  Created this ultra-concise version of annotations.
#
# == Todo
#
# * Might be nice to have a default object of annotation, eg. the next
#   method defined, like how +desc+ annotates a rake +task+.
# * The ann(x).name notation is kind of nice. Would like to add that
#   back-in if reasonable. Basically this require heritage to be an OpenObject
#   rather than just a hash.
#
# == Copying
#
# Copyright (c) 2005 Thomas Sawyer, George Moschovitis
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

warn "Libary facets/annotations.rb will be deprecated and spun spun off as new project."

require 'facets/hash/to_h'
require 'facets/hash/rekey'
require 'facets/hash/op'

# = Annotation
#
# Annotations allows you to annontate objects, including methods with arbitrary
# "metadata". These annotations don't do anything in themselves. They are
# merely comments. But you can put them to use. For instance an attribute
# validator might check for an annotation called :valid and test against it.
#
# Annotation is an OpenObject, and is used across the board for keeping annotations.
#
# Annotation class serves for both simple and inherited cases depending on whether
# a base class is given.
#
# == Synopsis
#
#   class X
#     attr :a
#     ann :@a, :valid => lambda{ |x| x.is_a?(Integer) }
#
#     def validate
#       instance_variables.each { |iv|
#         if validator = self.class.ann(iv)[:valid]
#           value = instance_variable_get(iv)
#           unless validator.call(vale)
#             raise "Invalid value #{value} for #{iv}"
#           end
#         end
#       }
#     end
#
#   end

#--
# By using a global veriable rather the definining a class instance variable
# for each class/module, it is possible to quicky scan all annotations for the
# entire system. To do the same without this would require scanning through
# the ObjectSpace. (Still which is better?)
#
#$annotations = Hash.new { |h,k| h[k] = {} }
#++

class Module

  def annotations
    #$annotations[self]
    @annotations ||= {}
  end

  def heritage(ref)
    ref = ref.to_sym
    ancestors.inject({}) { |memo, ancestor|
      ancestor.annotations[ref] ||= {}
      ancestor.annotations[ref] + memo
    }
  end

  # Set or read annotations.

  def ann( ref, keys_or_class=nil, keys=nil )
    return heritage(ref) unless keys_or_class or keys

    if Class === keys_or_class
      keys ||= {}
      keys[:class] = keys_or_class
    else
      keys = keys_or_class
    end

    if Hash === keys
      ref = ref.to_sym
      annotations[ref] ||= {}
      annotations[ref].update(keys.rekey)
    else
      key = keys.to_sym
      heritage(ref)[key]
    end
  end

  # To change an annotation's value in place for a given class or module
  # it first must be duplicated, otherwise the change may effect annotations
  # in the class or module's ancestors.

  def ann!( ref, keys_or_class=nil, keys=nil )
    #return heritage(ref) unless keys_or_class or keys
    return annotations[ref] unless keys_or_class or keys

    if Class === keys_or_class
      keys ||= {}
      keys[:class] = keys_or_class
    else
      keys = keys_or_class
    end

    if Hash === keys
      ref = ref.to_sym
      annotations[ref] ||= {}
      annotations[ref].update(keys.rekey)
    else
      key = keys.to_sym
      annotations[ref][key] = heritage(ref)[key].dup
    end
  end

end

# TITLE
#
#   Annotated Attributes
#
# DESCRIPTION:
#
#   This framework modifies the attr_* methods to allow easy
#   addition of annotations.
#
# COPYRIGHT:
#
#   Copyright (c) 2005 Thomas Sawyer
#
# LICENSE:
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#
# AUTHORS:
#
#   - Thomas Sawyer
#   - George Moschovitis

require 'facets/annotations.rb'
require 'facets/inheritor.rb'

# = Annotated Attributes
#
# This framework modifies the attr_* methods to allow easy addition of annotations.
# It the built in attribute methods (attr, attr_reader, attr_writer and attr_accessor),
# to allow annotations to added to them directly rather than requireing a separate
# #ann statement.
#
#   class X
#     attr :a, :valid => lambda{ |x| x.is_a?(Integer) }
#   end
#
# See annotation.rb for more information.
#
# NOTE This library was designed to be backward compatible with the
# standard versions of the same methods.

class ::Module

  inheritor :instance_attributes, [], :|

  def attr( *args )
    args.flatten!
    case args.last
    when TrueClass
      args.pop
      attr_accessor( *args )
    when FalseClass
      args.pop
      attr_reader( *args )
    else
      attr_reader( *args )
    end
  end

  alias :plain_reader :attr_reader
  alias :plain_writer :attr_writer
  alias :plain_accessor :attr_accessor

  code = ''

  [ :_reader, :_writer, :_accessor].each do |m|

    code << %{
      def attr#{m}(*args)
        args.flatten!

        harg={}; while args.last.is_a?(Hash)
          harg.update(args.pop)
        end

        raise ArgumentError if args.empty? and harg.empty?

        if args.empty?        # hash mode
          harg.each { |a,h| attr#{m}(a,h) }
        else
          klass = harg[:class] = args.pop if args.last.is_a?(Class)

          args.each { |a|
            plain#{m} a
            a = a.to_sym
            ann(a,harg)
          }
          instance_attributes!.concat( args )  #merge!

          # Use this callback to customize for your needs.
          if respond_to?(:attr_callback)
            attr_callback(self, args, harg)
          end

          # return the names of the attributes created
          return args
        end
      end
    }

  end

  class_eval( code )

  # TODO Should attribute alias be kept?
  alias_method :attribute, :attr_accessor

  # Return list of attributes that have a :class annotation.
  #
  #   class MyClass
  #     attr_accessor :test
  #     attr_accessor :name, String, :doc => 'Hello'
  #     attr_accessor :age, Fixnum
  #   end
  #
  #   MyClass.instance_attributes # => [:test, :name, :age, :body]
  #   MyClass.classified_attributes # => [:name, :age]

  def classified_attributes
    instance_attributes.find_all do |a|
      self.ann(a, :class)
    end
  end

end

