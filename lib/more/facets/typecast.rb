# = TypeCast
#
# Provides a generic simple type conversion utility. All the ruby core
# conversions are available by default.
#
#   "1234".cast_to Float     => 1234.0  (Float)
#   Time.cast_from("6:30")   => 1234.0   (Time)
#
# To implement a new type conversion, you have two choices, take:
#
#  class CustomType
#    def initialize(my_var)
#      @my_var = my_var
#    end
#  end
#
# Define a to_class_name instance method
#
#  class CustomType
#    def to_string
#      my_var.to_s
#    end
#  end
#
#  c = CustomType.new 1234
#  s.cast_to String   =>  "1234" (String)
#
# Define a from_class_name class method
#
#  class CustomType
#    def self.from_string(str)
#      self.new(str)
#    end
#  end
#
#  "1234".cast_to CustomType  =>  #<CustomType:0xb7d1958c @my_var="1234">
#
# Those two methods are equivalent in the result. It was coded like that to
# avoid the pollution of core classes with tons of to_* methods.
#
# The standard methods to_s, to_f, to_i, to_a and to_sym are also used by
# this system if available.
#
# == Faq
#
# Q. Why didn't you name the `cast_to` method to `to` ?
#
# A. Even if it would make the syntax more friendly, I suspect it could cause
# a lot of collisions with already existing code. The goal is that each
# time you call cast_to, you either get your result, either a
# TypeCastException
#
# == Authors
#
# * Jonas Pfenniger
# 
# == History
#
# * 2006-06-06 3v1l_d4y:
#   * Removed transformation options.
#   * Removed StringIO typecast. It is not required by default.
#   * Added TypeCastException for better error reporting while coding.
#
# == Todo
#
# * Consider how this might fit in with method signitures, overloading,
#   and expiremental euphoria-like type system.
#
# * Look to implement to_int, to_mailtext, to_r, to_rfc822text and to_str.
#
# == Copying
#
#   Copyright (c) 2004 Jonas Pfenniger
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.

require 'time'
require 'facets/string/methodize'
require 'facets/string/camelcase' #modulize'

# = Typecast
#
# Provides a generic simple type conversion utility. All the ruby core
# conversions are available by default.
#
#   "1234".cast_to Float     => 1234.0  (Float)
#   Time.cast_from("6:30")   => 1234.0   (Time)
#
# To implement a new type conversion, you have two choices, take:
#
#  class CustomType
#    def initialize(my_var)
#      @my_var = my_var
#    end
#  end
#
# Define a to_class_name instance method
#
#  class CustomType
#    def to_string
#      my_var.to_s
#    end
#  end
#
#  c = CustomType.new 1234
#  s.cast_to String   =>  "1234" (String)
#
# Define a from_class_name class method
#
#  class CustomType
#    def self.from_string(str)
#      self.new(str)
#    end
#  end
#
#  "1234".cast_to CustomType  =>  #<CustomType:0xb7d1958c @my_var="1234">
#
# Those two methods are equivalent in the result. It was coded like that to
# avoid the pollution of core classes with tons of to_* methods.
#
# The standard methods to_s, to_f, to_i, to_a and to_sym are also used by
# this system if available.
#
# == Faq
#
# Q. Why didn't you name the `cast_to` method to `to` ?
#
# A. Even if it would make the syntax more friendly, I suspect it could cause
# a lot of collisions with already existing code. The goal is that each
# time you call cast_to, you either get your result, either a
# TypeCastException
#
module TypeCast

  # Typecast method extensions for Object class.

  module Object
    # Cast an object to another
    #
    #    1234.cast_to(String)  => "1234"
    #
    def cast_to(klass)
      klass.cast_from(self)
    end
  end

  # Typecast method extensions for Class class.

  module Class
    # Cast on object from another.
    #
    #   String.cast_from(1234) => "1234"
    #
    def cast_from(object)
      method_to = "to_#{self.name.methodize}".to_sym
      if object.respond_to? method_to
        retval = object.send(method_to)
        return retval
      end
      method_from = "from_#{object.class.name.methodize}".to_sym
      if respond_to? method_from
        retval = send(method_from, object)
        return retval
      end
      raise TypeCastException, "TypeCasting from #{object.class.name} to #{self.name} not supported"
    end
  end

end

# TypeCast Exception error.
#
class TypeCastException < Exception; end

class Object #:nodoc:
  include TypeCast::Object
end

class Class #:nodoc:
  include TypeCast::Class
end

class Array #:nodoc:
  def self.cast_from(object)
    return super
  rescue TypeCastException
    return object.to_a if object.respond_to? :to_a
    raise
  end
end

class Float #:nodoc:
  def self.cast_from(object)
    return super
  rescue TypeCastException
    return object.to_f if object.respond_to? :to_f
    raise
  end
end

class Integer #:nodoc:
  def self.cast_from(object)
    return super
  rescue TypeCastException
    return object.to_i if object.respond_to? :to_i
    raise
  end
end

class String #:nodoc:
  def self.cast_from(object)
    return super
  rescue TypeCastException
    return object.to_s if object.respond_to? :to_s
    raise
  end
end

class Symbol #:nodoc:
  def self.cast_from(object)
    return super
  rescue TypeCastException
    return object.to_sym if object.respond_to? :to_sym
    raise
  end
end

# Special Extensions

class Class #:nodoc:
  # "string".cast_to Class         #=> String
  def self.from_string(string)
    string = string.to_s.camelcase #modulize
    base   = string.sub!(/^::/, '') ? Object : (self.kind_of?(Module) ? self : self.class )
    klass  = string.split(/::/).inject(base){ |mod, name| mod.const_get(name) }
    return klass if klass.kind_of? Class
    nil
  rescue
    nil
  end

  class << self
    alias_method :from_symbol, :from_string
  end
end

class Time #:nodoc:
  def self.from_string(string, options={})
    parse(string)
  rescue
    nil
  end
end

