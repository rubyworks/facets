require 'facets/filetest/separator_pattern'

module FileTest

  module_function

    # Is a path considered reasonably "safe"?
    #
    # Do not mistake this for a perfect solution!
    def safe?(path)
      case path
      when /\A(#{SEPARATOR_PATTERN}|\~)(#{SEPARATOR_PATTERN}|\*)+/
        false
      else
        true
      end
    end

end

