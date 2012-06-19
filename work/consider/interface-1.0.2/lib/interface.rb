# A module for implementing Java style interfaces in Ruby. For more information
# about Java interfaces, please see:
#
# http://java.sun.com/docs/books/tutorial/java/concepts/interface.html
#
module Interface
   # The version of the interface library.
   Interface::VERSION = '1.0.2'
   
   # Raised if a class or instance does not meet the interface requirements.
   class MethodMissing < RuntimeError; end

   alias :extends :extend

   private
 
   def extend_object(obj)
      return append_features(obj) if Interface === obj
      append_features(class << obj; self end)
      included(obj)
   end
 
   def append_features(mod)
      return super if Interface === mod

      inherited = (self.ancestors-[self]).select{ |x| Interface === x }
      inherited = inherited.map{ |x| x.instance_variable_get('@ids') }

      ids = @ids + inherited.flatten
      @unreq ||= []

      (ids - @unreq).uniq.each do |id|
         id = id.to_s if RUBY_VERSION.to_f < 1.9
         unless mod.instance_methods(true).include?(id)
            raise Interface::MethodMissing, id
         end
      end

      super mod
   end

   public
   
   # Accepts an array of method names that define the interface.  When this
   # module is included/implemented, those method names must have already been
   # defined. 
   #
   def required_methods(*ids)
      @ids = ids
   end

   # Accepts an array of method names that are removed as a requirement for
   # implementation. Presumably you would use this in a sub-interface where
   # you only wanted a partial implementation of an existing interface.
   #
   def unrequired_methods(*ids)
      @unreq ||= []
      @unreq += ids
   end
end

# The interface method creates an interface module which typically sets
# a list of methods that must be defined in the including class or module.
# If the methods are not defined, an Interface::MethodMissing error is raised.
#	
# A interface can extend an existing interface as well. These are called
# sub-interfaces, and they can included the rules for their parent interface
# by simply extending it.
#
# Example:
#
#   # Require 'alpha' and 'beta' methods
#   AlphaInterface = interface{
#      required_methods :alpha, :beta 
#   }
#
#   # A sub-interface that requires 'beta' and 'gamma' only
#   GammaInterface = interface{
#      extends AlphaInterface
#      required_methods :gamma
#      unrequired_methods :alpha
#   }
#
#   # Raises an Interface::MethodMissing error because :beta is not defined.
#   class MyClass
#      def alpha
#         # ...
#      end
#      implements AlphaInterface
#   end
#
def interface(&block)
   mod = Module.new
   mod.extend(Interface)
   mod.instance_eval(&block)
   mod
end
 
class Module
   alias :implements :include
end
