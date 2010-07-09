require 'facets/kernel/constant'

class Module

  # Returns the name of the module containing this one.
  #
  #   module ::ParentExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   ParentExample::M::N.parent_name # => "ParentExample::M"
  #
  def parent_name
    unless defined? @parent_name
      @parent_name = name =~ /::[^:]+\Z/ ? $`.freeze : nil
    end
    @parent_name
  end

  # Returns the module which contains this one according to its name.
  #
  #   module ::ParentExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   ParentExample::M::N.parent # => ParentExample::M
  #
  # The parent of top-level and anonymous modules is Object.
  #
  #   ParentExample.parent  # => Object
  #   Module.new.parent     # => Object
  #
  def parent
    parent_name ? constant(parent_name) : Object
  end

  # Returns all the parents of this module according to its name, ordered from
  # nested outwards. The receiver is not contained within the result.
  #
  #   module ::ParentExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   ParentExample.parents    # => [Object]
  #   ParentExample::M.parents # => [ParentExample, Object]
  #
  def parents
    parents = []
    if parent_name
      parts = parent_name.split('::')
      until parts.empty?
        parents << constant(parts * '::')
        parts.pop
      end
    end
    parents << Object unless parents.include?(Object)
    parents
  end

end

