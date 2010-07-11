require 'facets/kernel/meta_class'

module Kernel

  # Alias a method defined in the metaclass (ie. singleton class).
  #
  #   class MetaExample
  #     def self.y?; "y?" ; end
  #   end
  #
  #   MetaExample.meta_alias "ynot?", "y?"
  #
  #   MetaExample.ynot?  #=> "y?"
  #
  # CREDIT: Trans

  def meta_alias(*args)
    meta_class do
      alias_method(*args)
    end
  end

end

