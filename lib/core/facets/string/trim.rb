class String

  # Provides a margin controlled string.
  #
  #   x = %Q{
  #         | This
  #         |   is
  #         |     margin controlled!
  #         }.trim
  #
  # Note that this method used to be called `#margin`.
  #
  # @author Trans

  def trim(n=0)
    #d = /\A.*\n\s*(.)/.match( self )[1]
    #d = /\A\s*(.)/.match( self)[1] unless d

    md = /\A.*\n\s*(.)/.match(self) || /\A\s*(.)/.match(self)

    d = md[1]

    return '' unless d

    if n == 0
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, '')
    else
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, ' ' * n)
    end
  end

  # @deprecated Use String#trim instead.
  alias :margin :trim

end

