require 'facets/string/words'

class String

  # Iterate through each word of a string.
  #
  #   a = []
  #
  #   "list of words".each_word { |word| a << word }
  #
  #   a  #=> ['list', 'of', 'words']
  #
  def each_word(&block)
    words.each(&block)
  end

end
