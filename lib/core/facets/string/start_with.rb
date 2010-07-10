#--
# = Developer's Notes
#
# Old definition of start_with? written by Lucas Carlson
# and Blaine Cook was ...
#
#   index(prefix) == 0
# 
# I like the simplicity of this definition, but I could not
# find a way define #end_with? in similar terms and still
# accept regular expressions for the suffix. So I had to use
# Regexp match. On th upside, it can return MatchData
# which might be more useful.
#++

class String

  #unless method_defined?(:start_with?) # 1.8.7+

    # Does a string start with the given prefix?
    #
    #   "hello".start_with?("he")    #=> true
    #   "hello".start_with?("to")    #=> false
    #
    # Note: This definition is better than standard Ruby's
    # becuase it handles regular expressions.
    #
    # CREDIT: Juris Galang

    def start_with?(prefix)
      prefix = Regexp.escape(prefix.to_s) unless Regexp===prefix
      /^#{prefix}/.match(self) ? true : false
    end

  #end

  #unless method_defined?(:end_with?) # 1.8.7+

    # Does a string end with the given suffix?
    #
    #   "hello".end_with?("lo")    #=> true
    #   "hello".end_with?("to")    #=> false
    #
    # Note: This definition is better than standard Ruby's
    # becuase it handles regular expressions.
    #
    # CREDIT: Juris Galang

    def end_with?(suffix)
      suffix = Regexp.escape(suffix.to_s) unless Regexp===suffix
      /#{suffix}$/.match(self) ? true : false
    end

  #end

  alias_method :starts_with?, :start_with?
  alias_method :ends_with?  , :end_with?

end

