require 'facets/class_extend'

class Object

  # = Inheritor
  #
  # Create an inheritor "class attribute".
  #
  # Inheritor providse a means to store and inherit data via the class
  # heirarchy. An inheritor creates two methods one named after the key
  # that provides a reader. And one named after key! which provides the
  # writer. (Because of the unique nature of inheritor the reader and
  # writer can't be the same method.)
  #
  # The first argument is the inheritor's name. The second argument
  # is the archtype object. This object must be duplicable (via #dup).
  # The last argument is either the symbolic operator/method or a block
  # that specifies how one hierarchical level "integrates" with the next.
  #
  #   class X
  #     inheritor :foo, [], :+
  #   end
  #
  #   class Y < X
  #   end
  #
  #   X.x! << :a
  #   X.x => [:a]
  #   Y.x => [:a]
  #
  #   Y.x! << :b
  #   X.x => [:a]
  #   Y.x => [:a, :b]
  #
  # It is interesting to note that the only reason inheritor is needed
  # at all is becuase Ruby does not allow modules to be "inherited" at
  # the class-level, or conversely that the class-level is not a module
  # instead. Otherwise using #super at the class-level would suffice.
  #
  # NOTE: Adding an inheritor directly to Module or Class will probably
  # not do what is expected. Thankfully that usecase is likely a YAGNI,
  # but in anycase it is even more likely that it is not possible with
  # this code.
  #
  # CREDIT: Thomas Sawyer

  def inheritor(key, obj, op=nil, &fop)
    raise ArgumentError if op && fop

    if !fop
      op  = op ? op.to_sym : :+
      fop = lambda{ |o, x| o.__send__(op, x) }
    end

    #(class << self; self; end).module_eval do
    class_extend do

      define_method(key) do
        ancestors.reverse.inject(obj.dup) do |o, a|
          if a.respond_to?("#{key}!")
            fop.call(o, a.__send__("#{key}!"))
          else
            o
          end
        end
      end

      define_method("#{key}!") do
        if instance_variable_defined?("@#{key}")
          instance_variable_get("@#{key}")
        else
          instance_variable_set("@#{key}", obj.dup)
        end
      end

    end
  end

end


class Module

  # Like #inheritor but non-dynamic. The value of the inheritor
  # is copied from the immediate ancestor on first read.
  #
  # CREDIT: Thomas Sawyer

  def copy_inheritor(name, default={})
    class_extend do
      define_method(name) do
        if instance_variable_defined?("@#{name}")
          instance_variable_get("@#{name}")
        else
          if ancestors[1].respond_to?(name)
            instance_variable_set("@#{name}", ancestors[1].__send__(name).dup)
          else
            instance_variable_set("@#{name}", default)
          end
        end
      end
    end
  end

end

