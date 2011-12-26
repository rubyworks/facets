#--
# Author::    Thomas Sawyer, Tyler Rick
# Copyright:: Copyright (c) Thomas Sawyer, probably, since this is a derivative work
# License::   Ruby License
# Submit to Facets?:: Yes
# Developer notes::
# * Based on /usr/lib/ruby/gems/1.8/gems/facets-1.8.54/lib/facets/core/module/attr_tester.rb
# * Hey Thomas, don't you think Module#attr_tester should only create the read-only a? method and have another method that creates the writer (like there how we have attr_reader, _writer, and _accessor?) ? "tester" does not imply "setter" in my mind...
# * I'm going to rename this one to bool_attr_accessor, which calls both bool_attr_reader and bool_attr_writer
# * Then you also have the option to use bool_attr_reader and bool_attr_writer separately if you so desire.
# * Other changes made:
#   * Changed it so that if you call a!(false) it would actually set @a to false rather than leaving it unchanged. (I assume that was a bug.)
#++

# bool_attr_accessor

class Module
  # This creates a reader method for a boolean (flag) attribute (instance variable).
  #
  #   bool_attr_reader :a
  #
  # is equivalent to
  #
  #   def a?
  #     @a ? true : @a
  #   end
  #
  # Example:
  #   class Foo
  #     def set_it
  #       @a = true
  #     end
  #   end
  #   x = Foo.new
  #   x.a?        # => false
  #   x.set_it
  #   x.a?        # => true
  #
  def bool_attr_reader(*args)
    make = {}
    args.each { |a|
      make["#{a}?".to_sym] = %{
        def #{a}?(true_value=true)
          @#{a} ? true_value : @#{a}
        end
      }
    }
    module_eval make.values.join("\n"), __FILE__, __LINE__

    make.keys
  end

  # This creates a setter method for a boolean (flag) attribute (instance variable).
  #
  #   bool_attr_setter :a
  #
  # is equivalent to
  #
  #   def a!(switch=Exception)
  #     if switch == Exception
  #       @a = !@a
  #     else
  #       @a = switch ? true : false
  #       self
  #     end
  #   end
  #
  # This setter method can either be used to set it directly to true or false or to toggle it.
  #
  # Examples:
  #   x = Klass.new
  #   x.a! true   # sets @a to true
  #   x.a!        # toggles @a, so that it ends up being false
  #   x.a!        # toggles @a, so that it ends up being true
  #   x.a! false  # sets @a to false
  #
  def bool_attr_setter(*args)
    make = {}
    args.each { |a|
      make["#{a}!".to_sym] = %{
        def #{a}!(switch=Exception)
          if switch == Exception
            @#{a} = !@#{a}
          else
            @#{a} = switch ? true : false
                    # used to be @#{a} instead of false in Facets version
            self
          end
        end
      }
    }
    module_eval make.values.join("\n"), __FILE__, __LINE__
    make.keys
  end


  # This creates both a reader and a setter for a boolean (flag) attribute (instance variable).
  #
  #   bool_attr_accessor :a
  #
  # is equivalent to
  #
  #   bool_attr_reader :a
  #   bool_attr_setter :a
  #
  # Examples:
  #   x = Klass.new
  #   x.a! true   # sets @a to true
  #   x.a?        # => true
  #   x.a!        # toggles @a, so that it ends up being false
  #   x.a!        # toggles @a, so that it ends up being true
  #   x.a! false  # sets @a to false
  #
  def bool_attr_accessor(*args)
    bool_attr_reader *args
    bool_attr_setter *args
  end

end

# mbool_attr_accessor

class Module
  # This creates a reader method for a boolean (flag) class/module variable.
  #
  #   mbool_attr_reader :a
  #
  # is equivalent to
  #
  #   def self.a?
  #     @@a ? true : @@a
  #   end
  #
  # Works for both classes and modules.
  #
  def mbool_attr_reader(*args)
    make = {}
    args.each { |a|
      make["#{a}?".to_sym] = %{
        def self.#{a}?(true_value=true)
          @@#{a} ? true_value : @@#{a}
        end
      }
    }
    module_eval make.values.join("\n"), __FILE__, __LINE__
    make.keys
  end

  # This creates a setter method for a boolean (flag) class/module variable.
  #
  #   mbool_attr_setter :a
  #
  # is equivalent to
  #
  #   def self.a!(switch=Exception)
  #     if switch == Exception
  #       @@a = !@@a
  #     else
  #       @@a = switch ? true : false
  #       self
  #     end
  #   end
  #
  # Works for both classes and modules.
  #
  def mbool_attr_setter(*args)
    make = {}
    args.each { |a|
      # Initialize it first so that we won't have any NameErrors.
      module_eval %{ @@#{a} = nil if !defined?(@@#{a}) }, __FILE__, __LINE__

      make["#{a}!".to_sym] = %{
        def self.#{a}!(switch=Exception)
          if switch == Exception
            @@#{a} = !@@#{a}
          else
            @@#{a} = switch ? true : false
            self
          end
        end
      }
    }
    module_eval make.values.join("\n"), __FILE__, __LINE__
    make.keys
  end

  # This creates both a reader and a setter for a boolean (flag) class/module variable.
  #
  #   mbool_attr_accessor :a
  #
  # is equivalent to
  #
  #   mbool_attr_reader :a
  #   mbool_attr_setter :a
  #
  # Works for both classes and modules.
  #
  def mbool_attr_accessor(*args)
    mbool_attr_reader :a
    mbool_attr_setter :a
  end
end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test
require 'test/unit'
require 'rubygems'
require 'qualitysmith_extensions/object/ignore_access'

# Test that it works for *instances*
class TestBoolAttr < Test::Unit::TestCase
  def setup
    @x = C.new
  end

  class C_for_default_is_nil
    bool_attr_accessor :a, :b
  end

  # Also tests that it can create multiple accessors at once.
  def test1_default_is_nil
    assert_equal nil, C_for_default_is_nil.new.a? 
    assert_equal nil, C_for_default_is_nil.new.b? 
  end

  class C
    bool_attr_accessor :a
  end

  def test2_toggle
    assert_equal nil, @x.a? 
    @x.a!
    assert_equal true, @x.a? 
    @x.a!
    assert_equal false, @x.a? 
  end

  def test3_setter
    @x.a! true
    @x.a! true
    assert_equal true, @x.a? 

    @x.a! false 
    assert_equal false, @x.a? 
  end
  def test4_sets_to_boolean_even_if_try_to_set_to_other_type
    @x.a! "whatever" 
    assert_equal true, @x.a?     # Still returns a boolean even though we tried to set it to a string.

    @x.a! nil
    assert_equal false, @x.a?    # Still returns a boolean even though we tried to set it to nil.
  end
end

# Test that it works for *modules*
class TestForModules < Test::Unit::TestCase

  class M_for_default_is_nil
    mbool_attr_accessor :a
  end
  def test1_default_is_nil
    assert_equal nil, M_for_default_is_nil.a? 
  end

  module M
    mbool_attr_accessor :a
  end
  def test2_toggle
    assert_equal nil, M.a? 
    M.a!
    assert_equal true, M.a? 
    M.a!
    assert_equal false, M.a? 
  end
  def test3_setter
    M.a! true
    M.a! true
    assert_equal true, M.a? 

    M.a! false 
    assert_equal false, M.a? 
  end
  def test4_sets_to_boolean_even_if_try_to_set_to_other_type
    M.a! "whatever" 
    assert_equal true, M.a?     # Still returns a boolean even though we tried to set it to a string.

    M.a! nil
    assert_equal false, M.a?    # Still returns a boolean even though we tried to set it to nil.
  end
end

# Test that it also works for *classes*
class TestForClasses < Test::Unit::TestCase

  class C_for_default_is_nil
    mbool_attr_accessor :a
  end
  def test1_default_is_nil
    assert_equal nil, C_for_default_is_nil.a? 
  end

  class C
    mbool_attr_accessor :a
  end

  def test2_toggle
    C.access.class_variable_set :@@a, false 
    assert_equal false, C.a?    # otherwise would have been nil
    C.a!
    assert_equal true, C.a? 
    C.a!
    assert_equal false, C.a? 

    assert_equal ["@_ignore_access_functor"], C.instance_variables
    assert_equal ["@@a"], C.class_variables
  end

  def test3_setter
    C.a! true
    C.a! true
    assert_equal true, C.a? 

    C.a! false 
    assert_equal false, C.a? 
  end
  def test4_sets_to_boolean_even_if_try_to_set_to_other_type
    C.a! "whatever" 
    assert_equal true, C.a?     # Still returns a boolean even though we tried to set it to a string.

    C.a! nil
    assert_equal false, C.a?    # Still returns a boolean even though we tried to set it to nil.
  end
end


# Observation: You can also the normal bool_attr_accessor in conjunction with class << self.
# The methods generated seem to *behave* in the same way. Both techniques allow you to query the class, C.a?
# The only difference is in which *variables* are use to store the state:
# * class << self and the normal bool_attr_accessor:
#   Stores the state in an instance variable for the *class*: @a
# * mbool_attr_accessor:
#   Stores the state in a *class* variable: @@a
#
# Can someone explain to me the difference between class variables and instance variables of a class?
# It seems silly (confusing even!) to have both of them!
#
# My best explanation is that the fact that we can even *have* instance variables of a class does *not* mean it's a good idea
# to use them. It simply means that Matz made the language with as few arbitrary restrictions as possible. He made it
# technically *possible* to do a lot of things that it is probably not good practice to do... And one of those things is
# using instance variables of classes to store state information for that class.
#
# What do you think class variables are for? Exactly that! There's a *reason* we have both @a and @@a variables -- to
# *differentiate* between the two kinds of variables and keep programmers sane. So please don't blur the distinction and
# use the @a-type variable to do the job that @@a-type variables are for.
#
# Or am I missing something here?
#
class TestWith_class_self_and_plain_bool_attr_accessor < Test::Unit::TestCase

  class C_for_default_is_nil
    class << self
      bool_attr_accessor :a
    end
  end
  def test1_default_is_nil
    assert_equal nil, C_for_default_is_nil.a? 
  end

  class C
    class << self
      bool_attr_accessor :a
    end
  end
  # This is where I spotted a class that uses this technique:
  # * Test::Unit::Assertions::AssertionMessage

  def test_2_toggle
    assert_equal false, C.a?  # Why isn't it nil like it is for the instance use case of bool_attr_accessor?
    C.a!
    assert_equal true, C.a? 
    C.a!
    assert_equal false, C.a? 

    assert_equal ["@a"], C.instance_variables
    assert_equal [], C.new.instance_variables  # @a is an instance variable of the *class*  *not* objects of the class  -- weird!
    assert_equal [], C.class_variables
  end

  def test3_setter
    C.a! true
    C.a! true
    assert_equal true, C.a? 

    C.a! false 
    assert_equal false, C.a? 
  end
  def test4_sets_to_boolean_even_if_try_to_set_to_other_type
    C.a! "whatever" 
    assert_equal true, C.a?     # Still returns a boolean even though we tried to set it to a string.

    C.a! nil
    assert_equal false, C.a?    # Still returns a boolean even though we tried to set it to nil.
  end

end
=end

