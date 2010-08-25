# :title:       Prepend
# :copyright:   Copyright (c) 2005 Thomas Sawyer
# :license:     Ruby License
# :description: Prepend a module to another module, or to a class.

# = Prepend
#
# This is a module prepend system, which provides an elegant
# way to prepend code to the class hierarchy rather then append
# it (a la #include).
#
#   class C
#     def f
#       "f"
#     end
#   end
#
#   module M
#     def f
#       '{' + super + '}'
#     end
#   end
#
#   class C
#     prepend M
#   end
#
#   c = C.new
#   c.f  #=> "{f}"
#
# This works by overriding Class#new so that all prepended modules
# extend new instances of the class upon instantiation.
#
# If needed the original #new method has been aliased as #init.

class Class

  #
  def prepend(*mods)
    @prepend ||= []
    @prepend.concat(mods)
    @prepend
  end

  alias_method :init, :new

  def new(*args, &blk)
    o = allocate
    prepend.each do |mod|
      o.extend(mod)
    end
    o.__send__(:initialize, *args, &blk) #if private_method_defined?(:initialize)
    o
  end

end

