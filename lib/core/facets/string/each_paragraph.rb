require 'facets/string/paragraphs'

class String

  # Iterate through each paragraph of a string.
  #
  #   a = []
  #
  #   "One.\n\nTwo.".each_paragraph { |para| a << para }
  #
  #   a  #=> ["One.", "Two."]
  #
  # Without a block, returns an enumerator.
  #
  def each_paragraph(&block)
    return paragraphs.each unless block
    paragraphs.each(&block)
  end

end
