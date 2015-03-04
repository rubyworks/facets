require 'facets/string/indent'

class String

  # Preserve relative tabbing such that the line with the least amount 
  # of white space ends up with the given number of spaces before non-space
  # and all other lines move relative to it.
  #
  # Because of the nature of this method, leading tab characters (`\t`) must
  # be converted to spaces. The size of a tab can be set via the `:tab` option.
  # The default size is 2.
  #
  # If the `:lead` option is set, then the relative margin is determined
  # by the first non-blank line, instead of the minimum white-space for all
  # lines.
  #
  # Arguments
  #
  #   num   - The size of the desired margin. [Integer]
  #   opts  - Margin options. [Hash]
  #
  # Options
  #
  #   :tab  - Size of tab character in spaces. [Integer]
  #   :lead - Use first non-blank line as relative marker. [Boolean] 
  #
  # Returns a new String with adjusted margin. [String]
  #
  # Author: Gavin Sinclair
  # Author: Trans

  def margin(num=nil, opts={})
    # TODO: temporary to help people transition
    raise ArgumentError, "String#margin has been renamed to #trim." unless num

    tab = opts[:tab] || 2
    str = gsub("\t", " " * tab)  # TODO: only leading tabs ?

    if opts[:lead]
      if self =~ /^( *)\S/
        indent(num - $1.length)
      else
        self
      end
    else
      min = []
      str.each_line do |line|
        next if line.strip.empty?
        min << line.index(/\S/)
      end
      min = min.min
      str.indent(num - min)
    end
  end
end
