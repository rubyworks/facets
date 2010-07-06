class String

  # Remove quotes from string.
  #
  #   "'hi'".dequote    #=> "hi"
  #
  # CREDIT: Trans

  def dequote
    s = self.dup

    case self[0,1]
    when "'", '"', '`'
      s[0] = ''
    end

    case self[-1,1]
    when "'", '"', '`'
      s[-1] = ''
    end

    return s
  end

end
