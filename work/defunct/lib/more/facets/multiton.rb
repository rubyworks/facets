# TITLE:
#
#   Multiton
#
# SUMMARY:
#
#   Multiton module that ensures only one object to be allocated
#   for a given argument list.
#
# COPYRIGHT:
#
#   Copyright (c) 2005 Ara T. Howard, Thomas Sawyer
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
#   - Ara T. Howard
#   - Thomas Sawyer
#
# TODOs:
#
#   - Appaeerntly there are still threading issues. There is another proposed
#     implementation to consider.


# = Multiton
#
# Multiton module that ensures only one object to be allocated for a given
# argument list.
#
# The 'multiton' pattern is similar to a singleton, but instead of only one
# instance, there are several similar instances.  It is useful when you want to
# avoid constructing objects many times because of some huge expense (connecting
# to a database for example), require a set of similar but not identical
# objects, and cannot easily control how many times a contructor may be called.
#
# == Synopsis
#
#   class SomeMultitonClass
#     include Multiton
#     attr :arg
#     def initialize(arg)
#       @arg = arg
#     end
#   end
#
#   a = SomeMultitonClass.new(4)
#   b = SomeMultitonClass.new(4)   # a and b are same object
#   c = SomeMultitonClass.new(2)   # c is a different object
#
# == Previous Behavior
#
# In previous versions of Multiton the #new method was made
# private and #instance was used in its stay --just like Singleton.
# But this has proved less desirable for Multiton since Multitions can
# have multiple instances, not just one.
#
# So instead Multiton now defines #create as a private alias of
# the original #new method (just in case it is needed) and then
# defines #new to handle the multiton, and #instance is provided
# as an alias for it.
#
# So if you must have the old behavior, all you need do is re-alias
# #new to #create and privatize it.
#
#   class SomeMultitonClass
#     include Multiton
#     alias_method :new, :create
#     private :new
#     ...
#   end
#
# Then only #instance will be available for creating the Multiton.
#
# == How It Works
#
# A pool of objects is searched for a previously cached object,
# if one is not found we construct one and cache it in the pool
# based on class and the args given to the contructor.
#
# A limitation of this approach is that it is impossible to
# detect if different blocks were given to a contructor (if it takes a
# block).  So it is the constructor arguments _only_ which determine
# the uniqueness of an object. To workaround this, define the _class_
# method ::multiton_id.
#
#   def Klass.multiton_id(*args, &block)
#     # ...
#   end
#
# Which should return a hash key used to identify the object being
# constructed as (not) unique.

module Multiton

  # Pools of objects cached on class type.
  POOLS = {}

  # Method which can be defined by a class to determine object uniqueness.
  MULTITON_ID_HOOK = :multiton_id

  # Method which can be defined by a class to create multiton objects.
  MULTITON_NEW_HOOK = :multiton_new

  def self.append_features( klass )
    class << klass
      unless method_defined?(MULTITON_NEW_HOOK)
        alias_method MULTITON_NEW_HOOK, :new
      end

      def instance(*args, &block)
        k = begin
          # if the class defined 'multiton_id' we use this as the key
          send MULTITON_ID_HOOK, *args, &block
        rescue NameError
          # otherwise we simply use the argument list
          args
        end

        k = begin
          Marshal.dump(k)
        rescue TypeError
          k
        end

        unless obj = (POOLS[self] ||= {})[k]
          begin
            critical = Thread.critical
            Thread.critical = true
            obj = (POOLS[self][k] = send(MULTITON_NEW_HOOK, *args, &block))
          ensure
            Thread.critical = critical # restore state
          end
        end

        return obj
      end

      alias_method :create, :new
      alias_method :new, :instance
    end
  end

  # Recursive dehash function. This converts hash into associative
  # arrays, and any hashes that contains, etc.
  #def self.dehash(arg)
  #  case arg
  #  when Hash
  #    arg.to_a.collect{|a| dehash(a)}
  #  when Array
  #    arg.collect{|a| dehash(a)}
  #  else
  #    arg
  #  end
  #end

end

#--
# Deprecated use, now use #private_multiton method after including Multiton
#
#  module MultitonInstance
#
#   def self.append_features(klass)
#     klass.private_class_method(:new)
#     def klass.instance(*args, &block)
#       # if the class has #multiton_id we use this as the key
#       # otherwise we simply use the argument list.
#       k = (respond_to?(MULTITON_ID_HOOK) ? send(MULTITON_ID_HOOK, *args, &block) : args)
#       unless (obj = (POOLS[self] ||= {})[k])
#         begin
#           critical = Thread.critical
#           Thread.critical = true
#           meth = self.respond_to?(MULTITON_NEW_HOOK) ? MULTITON_NEW_HOOK : :new
#           obj = (POOLS[self][k] = self.send(meth, *args, &block))
#         ensure
#           Thread.critical = critical # restore state
#         end
#       end
#       return obj
#     end
#   end
#
# end
#++


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

=begin test

  require 'test/unit'

  #
  # EXAMPLE A - STANDARD USAGE
  #
  class TC_Multiton_A < Test::Unit::TestCase

    class SomeMultitonClass
      include Multiton
      attr :arg
      def initialize(arg)
        @arg = arg
      end
    end

    def test_standard

      a = SomeMultitonClass.instance(4)
      b = SomeMultitonClass.instance(4)     # a and b are same object
      c = SomeMultitonClass.instance(2)     # c is a different object

      assert_equal( a, b )
      assert_equal( 42, [a.arg,b.arg].max * 10 + c.arg )

    end

  end

  #
  # EXAMPLE B - MODIFY AN EXISTING CLASS, SHARED FILEHANDLES
  #
  class TC_Multiton_B < Test::Unit::TestCase

    class ::File
      include Multiton
    end

    def test_modify_existing

      lineno = __LINE__
      # HERE1
      # HERE2

      a = File.instance(__FILE__)
      b = File.instance(__FILE__)

      assert_equal( a, b )

      lineno.times{ a.gets }

      assert_equal( "# HERE1", a.gets.strip )
      assert_equal( "# HERE2", b.gets.strip )

    end

  end

  #
  # EXAMPLE C - INHERITENCE
  #
  class TC_Multiton_C < Test::Unit::TestCase

    class A < String
      include Multiton
    end

    # B is also a multiton - with it's OWN object cache
    class B < A; end

    def test_inheritence

      # w is the same object as x, y is the same object as z
      w,x,y,z = A.instance('A'), A.instance('A'), B.instance('B'), B.instance('B')

      assert_equal( w.object_id, x.object_id ) # -> true
      assert_equal( y.object_id, z.object_id ) # -> true

      a = B.instance('A')
      b = B.instance('A')

      assert_not_equal( a.object_id, w.object_id ) # -> false (each class has it's own pool)
      assert_equal( a.object_id, b.object_id )     # -> true

    end

  end


  #
  # EXAMPLE D - MULTIPLE MODULE INCLUSION (does nothing)
  #
  class TC_Multiton_D < Test::Unit::TestCase

    class A < String
      include Multiton
    end

    # B is also a multiton - with it's OWN object cache
    class B < A; end

    def test_multiple

      # w is the same object as x, y is the same object as z
      w,x,y,z = A.instance('A'), A.instance('A'), B.instance('B'), B.instance('B')

      yz_id = y.object_id || z.object_id

      B.class_eval {
        include Multiton
      }

      # y is not only the same object as z, but they are both the same object(s)
      # as from EXAMPLE C

      y,z = B.instance('B'), B.instance('B')

      assert_equal( y.object_id, yz_id )   # -> true
      assert_equal( z.object_id, yz_id ) # -> true

    end

  end

  #
  # EXAMPLE E - SO YOU WANNA USE NEW INSTEAD OF INSTANCE...
  #
  class TC_Multiton_E < Test::Unit::TestCase

    module K
      # use an inner class which is itself a multiton
      class K < String; include Multiton; end

      # define a new which returns a mutltion using #instance...
      class << self
        def new(*args, &block)
          K.instance *args, &block
        end
      end
    end

    def test_new

      the = K.new '4'
      answer = K.new '2'

      assert_equal( "42", sprintf( "%s%s", the, answer ) )  #-> 42
      assert_equal( K::K, the.class )  #-> K::K

    end

  end

  #
  # EXAMPLE F - using Klass.multiton_id
  #
  class TC_Multiton_F < Test::Unit::TestCase

    class Klass
      include Multiton

      def initialize( important, not_important )
        @important, @not_important = important, not_important
      end

      def Klass.multiton_id(*args, &block)
        # we consider only the first arg
        important, not_important = *args
        important
      end
    end

    def test_using_id
      a = Klass.instance( :a, :b )
      b = Klass.instance( :a, :c )
      c = Klass.instance( :b, :b )

      assert_equal( a, b )
      assert_not_equal( a, c )
      assert_not_equal( b, c )
    end

  end

=end
