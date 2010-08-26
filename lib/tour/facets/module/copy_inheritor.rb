class Module

  # Like #inheritor but non-dynamic. The value of the inheritor
  # is copied from the ancestor on first read.
  #
  # CREDIT: Thomas Sawyer

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

