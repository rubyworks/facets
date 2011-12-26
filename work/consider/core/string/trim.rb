class String
	  def rtrim(char)
		      dump.rtrim!(char)
		        end

	    def rtrim!(char)
		        gsub!(/#{Regexp.escape(char)}+$/, '')
				  end

	      def ltrim(char)
		          dump.ltrim!(char)
			    end

	        def ltrim!(char)
			    gsub!(/^#{Regexp.escape(char)}+/, '')
			      end


=begin
Trims a string:

    * removes one initial blank line
    * removes trailing spaces on each line
    * if margin is given, removes initial spaces up to and including the margin on each line, plus one space

This is designed specifically for working with inline documents. Here-documents are great, except they tend to go against the indentation of your code. This method allows a convenient way of using %{}-style documents. For instance:

  USAGE = %{
    | usage: prog [-o dir] -h file...
    |   where
    |     -o dir         outputs to DIR
    |     -h             prints this message
  }.trim("|")

  # USAGE == "usage: prog [-o dir] -h file...\n  where"...
  # (note single space to right of margin is deleted)

Note carefully that if no margin string is given, then there is no clipping at the beginning of each line and your string will remain indented. You can use tabto(0) to align it with the left of screen (while preserving relative indentation).

  USAGE = %{
    usage: prog [-o dir] -h file...
      where
        -o dir         outputs to DIR
        -h             prints this message
  }.trim.tabto(0)

  # USAGE == (same as last example)

[Source]
=end

# File lib/extensions/string.rb, line 194
    def trim(margin=nil)
      s = self.dup
      # Remove initial blank line.
      s.sub!(/\A[ \t]*\n/, "")
      # Get rid of the margin, if it's specified.
      unless margin.nil?
        margin_re = Regexp.escape(margin || "")
        margin_re = /^[ \t]*#{margin_re} ?/
        s.gsub!(margin_re, "")
      end
      # Remove trailing whitespace on each line
      s.gsub!(/[ \t]+$/, "")
      s
    end


end 

