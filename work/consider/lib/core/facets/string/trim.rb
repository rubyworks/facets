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
end 

