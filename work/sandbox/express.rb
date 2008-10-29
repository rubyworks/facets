# This should look in a master Extensions module
# instead of the class/modules themselves.
# B/c this way thay can be loaded via the same file.
# Example: 
#   # string/align.rb
#   class String
#     module Align
#       def align_center
#          ...
#       end
#     end
#   end
# With this one would have to have a separate require that
# include the Align module into Strin gautomatically (or
# else alwys do it by hand *ick*). But if we just had:
#   # string/align.rb
#   class String
#     def align_center
#       ...
#     end
#   end
# Then we can use module_require to load this in a mater 
# extensions module. And #express could just use that.

module Kernel

  # Extend an object with an internal
  # extension module.
  #
  #   class Array
  #     module Random
  #       def shuffle
  #         [] # ...
  #       end
  #       # ...
  #     end
  #   end
  #
  #   a = [1,2,3]
  #   a.shuffle           #=> NoMethodError
  #   a.express(:Random)
  #   a.shuffle           #=> []

  def express(name)
    extend self.class.const_get(name.to_s.capitalize)
  end

end
