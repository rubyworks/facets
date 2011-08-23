class Module

  # Returns the module or class containing the receiver.
  #
  #   module ::HomeExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   HomeExample::M::N.home  #=> HomeExample::M
  #
  # The home of a top-level module/class is Object.
  #
  #   HomeExample.home   #=> Object
  #
  # This method is called *home* because techinally a module or class
  # is just a constant reference, and as such can reside with multiple
  # namespaces, like any variable. For example:
  #
  #   module OtherPlace
  #     M = ::HomeExample::M
  #   end
  #
  # In this example, you might think that +OtherPlace::M+'s home would be
  # +OtherPlace+, but +OtherPlace::M+ is the same object as +HomeExample::M+,
  # and it can have only one "home" --the original location of it's definition.
  def home
    #homename = /::[^:]+\Z/ =~ name ? $` : nil
    if homename
      homename.split(/::/).inject(self) do |mod, cref|
        if /\:(0x.*?)\>$/ =~ cref   # TODO: does this ever happen?
          #p $1.to_i(16)
          ObjectSpace._idref($1.to_i(16))
        else
          mod.const_get(cref)
        end
      end
    else
      Object
    end
  end

  # Returns the name of module or class containing the receiver.
  #
  #   module ::HomeExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   HomeExample::M::N.homename  #=> "HomeExample::M"
  #
  # See also Module#basename.
  def homename
    /::[^:]+\Z/ =~ name ? $` : nil
  end

  # Original name for #homename.
  alias_method :modname, :homename

  # Returns all the namespaces of this module according ordered from
  # nearest and moving outwards. The receiver is not contained within
  # the result.
  #
  #   module ::HouseExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   HouseExample.housing        #=> [Object]
  #   HouseExample::M.housing     #=> [HouseExample, Object]
  #   HouseExample::M::N.housing  #=> [HouseExample::M, HouseExample, Object]
  #
  # Compare this to +Module.nesting+.
  def housing
    n = []
    name.split(/::/).inject(self) do |mod, cref|
      c = mod.const_get(cref) ; n.unshift(c) ; c
    end
    n << Object # ?
    n.shift # we really don't need +self+ too.
    n
  end

end
