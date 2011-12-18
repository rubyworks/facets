require 'facets/string/tabto'

class String

  # Aligns each line n spaces.
  #
  # CREDIT: Gavin Sinclair
  #
  def tab(n)
    gsub(/^ */, ' ' * n)
  end

  # NOTE: Deprecated #taballto which was an alias for #tab.
  #alias_method :taballto, :tab

end

