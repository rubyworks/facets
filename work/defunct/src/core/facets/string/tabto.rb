require 'facets/string/indent'

class String

  # Preserves relative tabbing.
  # The first non-empty line ends up with n spaces before nonspace.
  #
  # CREDIT: Gavin Sinclair

  def tabto(n)
    if self =~ /^( *)\S/
      indent(n - $1.length)
    else
      self
    end
  end

end

