class String

  # Upcase first letter.
  #
  # NOTE: One might argue that this method should behave the same as
  # +#upcase+ and rather this behavior should be in place of +#captialize+.
  # Probably so, but since Matz has already defined +#captialize+ the way
  # it is, this name seems most fitting to the missing behavior.
  #
  def uppercase
    str = to_s
    str[0,1].upcase + str[1..-1]
  end

  # Downcase first letter.
  #
  def lowercase
    str = to_s
    str[0,1].downcase + str[1..-1]
  end

end

