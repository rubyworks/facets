require 'facets/string/words'

class String

  # Iterate through each word of a string.
  #
  #   "a string".each_word { |word, range| ... }
  #
  def each_word(&block)
    words.each(&block)
  end

end
