require 'facets/string/indent'

class String

  # Preserves relative tabbing. The first non-empty line ends up with `n`
  # spaces before nonspace.
  #
  # @author Gavin Sinclair

  def tab(n)
    if self =~ /^( *)\S/
      indent(n - $1.length)
    else
      self
    end
  end

  # @deprecated Use String#tab instead.

  alias :tabto, :tab

end

