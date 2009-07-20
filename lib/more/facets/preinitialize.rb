# TITLE:
#
#   Preinitialize
#
# DESCRIPTION:
#
#   Presend a module to another module, or to a class.
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

require 'facets/kernel/object'  # for object_class

# = Preinitialize
#
# This is an object preinitialize system, which provides
# an elegant way to initialize an object allowing the
# class to provide additional default structure to an
# object prior to calling initialize.
#
# In effect it does two things after allocating the object
# but prior to initializing it.
#
# First, it calls the class method #default_instance_variables,
# which returns a hash and by default returns the hash
# stored in @default_instance_variables. It uses this to
# pre-define instance variables.
#
# Then it goes to the top of the class hierarchy  and works
# it's way down calling #preinitialize if defined.
# WARNING! It is rather useless to use <tt>super</tt>
# inside the any preinitialize hook.
#
#   module M
#     def preinitialize
#       @a = 23
#     end
#   end
#
#   class X
#     include M
#     def a ; @a ; end
#   end
#
#   x = X.new
#   x.a         #=> 23
#
# If neded the original new method has been aliased, albeit
# <tt>postinitialize_new</tt> is probably a bit of a misnomer.

#--
# class Module
#
#   def default_instance_variables(complete=false)
#     @default_instance_variables ||= {}
#     unless complete
#       return @default_instance_variables
#     else
#       parent = ancestors[1]
#       if parent
#         return @default_instance_variables.merge(parent.default_instance_variables)
#       else
#         return @default_instance_variables
#       end
#     end
#   end
#
# end
#++

class Class
  alias_method :postinitialize_new, :new

  def new(*args, &blk)
    o = allocate

    #if respond_to?(:default_instance_variables)
    #  default_instance_variables.each{|k,v| o.instance_variable_set( "@#{k.to_s.gsub(/\W$/,'')}",v )}
    #end

    a = ancestors
    until a.empty?
      m = a.pop
      #if m.private_instance_methods.include?('preinitialize') or m.public_instance_methods.include?('preinitialize')
      if m.method_defined?('preinitialize') or m.private_method_defined?('preinitialize')
        im = instance_method('preinitialize')
        im.arity == 0 ? im.bind(o).call : im.bind(o).call(*args, &blk)
      end
    end

    o.__send__(:initialize, *args, &blk) if o.object_class.private_method_defined?(:initialize)

    o
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

  class TC_Preinitalize < Test::Unit::TestCase

    module M
      def preinitialize
        @a = 10
      end
    end

    class X
      include M
      def a ; @a ; end
    end

    class Y < X
      def initialize
        super
      end
    end

    def test_01
      x = X.new
      assert_equal( 10, x.a )
    end

    def test_01
      y = Y.new
      assert_equal( 10, y.a )
    end

  end

=end
