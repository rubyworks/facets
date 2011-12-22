require 'facets/module/class_extend'

class Module

  # Like #class_inheritor but non-dynamic. The value of the inheritor
  # is copied from the ancestor on first read.
  #
  #   c = Class.new do
  #     def self.x; ['x']; end
  #   end
  #
  #   d = Class.new(c) do
  #     copy_inheritor :x
  #   end
  #
  #   d.x  #=> ['x']
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Thomas Sawyer
  #
  # @uncommon
  #   require 'facets/module/copy_inheritor'
  #
  def copy_inheritor(name, default={})
    class_extend do
      define_method(name) do
        if instance_variable_defined?("@#{name}")
          instance_variable_get("@#{name}")
        else
          if anc = ancestors[1..-1].find{ |a| a.respond_to?(name) }
            value = anc.__send__(name)
            value = value.dup rescue value
            instance_variable_set("@#{name}", value)
          else
            instance_variable_set("@#{name}", default)
          end
        end
      end
    end
  end

end

