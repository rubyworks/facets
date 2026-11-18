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
  #     "  abc\n    xyz".margin(0)              #=> "abc\n  xyz"
  #     "    abc\n  xyz".margin(2, lead: true)  #=> "  abc\nxyz"
  #
  # If the `:flush` option is set, relative tabbing is not preserved: every
  # line that isn't blank gets exactly the given number of spaces before
  # non-space, whatever spaces or tabs it started with. Blank lines are
  # left as they are.
  #
  #     "abc\n    xyz".margin(2)               #=> "  abc\n      xyz"
  #     "abc\n    xyz".margin(2, flush: true)  #=> "  abc\n  xyz"
  #
  # Arguments:
  #
  #   num   - The size of the desired margin. [Integer]
  #   opts  - Margin options. [Hash]
  #
  # Options:
  #
  #   :tab   - Size of tab character in spaces. [Integer]
  #   :lead  - Use first non-blank line as relative marker. [Boolean]
  #   :flush - Give every line the same margin. [Boolean]
  #
  # Returns a new String with adjusted margin. [String]
  #
  # Author: Gavin Sinclair
  # Author: Trans

  def margin(num=nil, opts={})
    # TODO: temporary to help people transition
    raise ArgumentError, "String#margin has been renamed to #trim." unless num

    return gsub(/^[ \t]*(?=\S)/, ' ' * num) if opts[:flush]

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
