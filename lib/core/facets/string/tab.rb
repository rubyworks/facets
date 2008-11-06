require 'facets/string/tabto'
require 'facets/string/margin'
require 'facets/string/indent'
require 'facets/string/expand_tab'

class String

  # Aligns each line n spaces.
  #
  # CREDIT: Gavin Sinclair
  #
  def tab(n)
    gsub(/^ */, ' ' * n)
  end

  # LOG: Deprecated #taballto which was an alias for #tab.
  #alias_method :taballto, :tab

end

