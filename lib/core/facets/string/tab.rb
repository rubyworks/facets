require 'facets/string/indent'

class String

  # Preserves relative tabbing such that the line with the least amount 
  # of white space ends up with `n` number of spaces before non-space and
  # all other lines move relative to it.

  def tab(n)
    str = gsub("\t", "  ")  # option?

    min = []
    str.each_line do |line|
      next if line.strip.empty?
      min << line.index(/\S/)
    end
    min = min.min

    str.indent(n - min)
  end

  # Preserves relative tabbing, such that the first non-empty line ends up with
  # `n` number of spaces before non-space, and all subsequent lines move relative
  # to the first.
  #
  # @author Gavin Sinclair

  def tabto(n)
    if self =~ /^( *)\S/
      indent(n - $1.length)
    else
      self
    end
  end

end

