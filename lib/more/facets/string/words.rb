require 'facets/string/fold'

class String

  module Words

    # Returns an array of characters.
    #
    #   "abc 123".words  #=> ["abc","123"]

    def words
      self.split(/\s+/)
    end

    # Iterate through each word of a string.
    #
    #   "a string".each_word { |word, range| ... }

    def each_word( &yld )
      rest_of_string = self
      wordfind = /([-'\w]+)/
      arity = yld.arity
      offset = 0
      while wmatch = wordfind.match(rest_of_string)
        word = wmatch[0]
        range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
        rest_of_string = wmatch.post_match
        if arity == 1
          yld.call(word)
        else
          yld.call(word, range)
        end
        offset = self.length - rest_of_string.length
      end
    end

    # Filters out words from a string based on block test.
    #
    #   "a string".word_filter { |word| word =~ /^a/ }  #=> "string"
    #
    #   CREDIT: George Moschovitis

    def word_filter( &blk )
      s = self.dup
      s.word_filter!( &blk )
    end

    # In place version of #word_filter.
    #
    #   "a string".word_filter { |word| ... }
    #
    #   CREDIT: George Moschovitis

    def word_filter! #:yield:
      rest_of_string = self
      wordfind = /(\w+)/
      offset = 0
      while wmatch = wordfind.match(rest_of_string)
        word = wmatch[0]
        range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
        rest_of_string = wmatch.post_match
        self[range] = yield( word ).to_s
        offset = self.length - rest_of_string.length
      end
      self
    end

    # TODO: This is alternateive from glue: worth providing?
    #
    # Enforces a maximum width of a string inside an
    # html container. If the string exceeds this maximum width
    # the string gets wraped.
    #
    # Not really useful, better use the CSS overflow: hidden
    # functionality.
    #
    # === Input:
    # the string to be wrapped
    # the enforced width
    # the separator used for wrapping
    #
    # === Output:
    # the wrapped string
    #
    # === Example:
    #  text = "1111111111111111111111111111111111111111111"
    #  text = wrap(text, 10, " ")
    #  p text # => "1111111111 1111111111 1111111111"
    #
    # See the test cases to better understand the behaviour!

    #   def wrap(width = 20, separator = " ")
    #     re = /([^#{separator}]{1,#{width}})/
    #     scan(re).join(separator)
    #   end

    # Word wrap a string not exceeding max width.
    #
    #   puts "this is a test".word_wrap(4)
    #
    # _produces_
    #
    #   this
    #   is a
    #   test
    #
    #   CREDIT: Gavin Kistner
    #   CREDIT: Dayne Broderson

    def word_wrap( col_width=80 )
      self.dup.word_wrap!( col_width )
    end

    # As with #word_wrap, but modifies the string in place.
    #
    #   CREDIT: Gavin Kistner
    #   CREDIT: Dayne Broderson

    def word_wrap!( col_width=80 )
      self.gsub!( /(\S{#{col_width}})(?=\S)/, '\1 ' )
      self.gsub!( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
      self
    end

    # old def

    #def word_wrap(max=80)
    #  c = dup
    #  c.word_wrap!(max)
    #  c
    #end

    #def word_wrap!(max=80)
    #  raise ArgumentError, "Wrap margin too low: #{n}" if max <= 2
    #  #gsub!( Regexp.new( "(.{1,#{max-1}}\\w)\\b\\s*" ), "\\1\n")
    #  gsub!( /(.{1,#{max-1}}\S)([ ]|\n)/, "\\1\n")
    #end

    # Returns short abstract of long strings; not exceeding +range+
    # characters. If range is an integer then the minimum is 20%
    # of the maximum. The string is chopped at the nearest word
    # if possible, and appended by +ellipsis+, which defaults
    # to '...'.
    #
    #   CREDIT: George Moschovitis
    #   CREDIT: Trans

    def brief(range=76, ellipsis="...")
      if Range===range
        min = range.first
        max = range.last
      else
        max = range
        min = max - (max/5).to_i
        range = min..max
      end

      if size > max
        cut_at = rindex(/\b/, max) || max
        cut_at = max if cut_at < min
        xstring = slice(0, cut_at)
        xstring.chomp(" ") + ellipsis
      else
        self
      end
    end

  end

  include Words

end

