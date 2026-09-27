require 'facets/hash/symbolize_keys'

class Hash

  # Rails' name for #symbolize_keys.
  #
  #   {'a'=>1}.to_options  #=> {:a=>1}
  #
  alias_method :to_options,  :symbolize_keys

  # Rails' name for #symbolize_keys!.
  alias_method :to_options!, :symbolize_keys!

end
