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
#     include Preinitializable
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

module Preinitializable

  def self.included(base)
    if Class===base
      (class << base; self; end).__send__(:alias_method, :post_new, :new)
      base.extend Meta
    else
      (class << base; self; end).__send__(:define_method, :included, &method(:included))
    end
  end

  module Meta

    def new(*args, &blk)
      o = allocate
      #if respond_to?(:default_instance_variables)
      #  default_instance_variables.each{|k,v| o.instance_variable_set( "@#{k.to_s.gsub(/\W$/,'')}",v )}
      #end
      a = ancestors
      until a.empty?
        m = a.pop
        if m.private_instance_methods(false).include?('preinitialize') or
             m.protected_instance_methods(false).include?('preinitialize') or
               m.public_instance_methods(false).include?('preinitialize')
          im = instance_method('preinitialize')
          im.arity == 0 ? im.bind(o).call : im.bind(o).call(*args, &blk)
        end
      end
      o.__send__(:initialize, *args, &blk) if o.class.private_method_defined?(:initialize)
      o
    end

  end

end

