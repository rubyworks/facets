class String

  # Control the margin of a string using a trim character.
  #
  # The first character of the second line of the string
  # is used as the trim character. This method is useful
  # when literal multi-line strings are needed in code.
  # 
  # num - Number of extra spaces with which to replace the
  #       trim character. [Integer]
  #
  # Examples
  #
  #     x = %Q{
  #           | This
  #           |   is
  #           |    trim!
  #           }.trim
  #
  # Returns string with the margin trimed-off.
  #
  # Note: This this method used to be called `margin` prior to Facets 3.0.
  #
  # Since: 3.0.0
  # Author: Trans

  def trim(num=0)
    #d = /\A.*\n\s*(.)/.match( self )[1]
    #d = /\A\s*(.)/.match( self)[1] unless d

    md = /\A.*\n\s*(.)/.match(self) || /\A\s*(.)/.match(self)

    d = md[1]

    return '' unless d

    if num == 0
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, '')
    else
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, ' ' * num)
    end
  end

end

