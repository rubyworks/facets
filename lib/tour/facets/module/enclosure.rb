require 'facets/kernel/constant'
require 'facets/module/namespace'

class Module

  # Returns the module which contains this one according to its name.
  #
  #   module ::EncExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   EncExample::M::N.enclosure  #=> EncExample::M
  #
  # The parent of top-level and anonymous modules is Object.
  #
  #   EncExample.enclosure   #=> Object
  #   Module.new.enclosure   #=> Object
  #
  def enclosure
    namespace ? constant(namespace) : Object
  end

  # Returns all the parents of this module according to its name, ordered from
  # nested outwards. The receiver is not contained within the result.
  #
  #   module ::EncExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   EncExample.enclosures      #=> [Object]
  #   EncExample::M.enclosures   #=> [EncExample, Object]
  #
  def enclosures
   enclosures = []
    if namespace
      parts = namespace.split('::')
      until parts.empty?
        enclosures << constant(parts * '::')
        parts.pop
      end
    end
    enclosures << Object unless enclosures.include?(Object)
    enclosures
  end

end

