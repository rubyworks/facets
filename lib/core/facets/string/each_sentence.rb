require 'facets/string/sentences'

class String

  # Iterate through each sentence of a string.
  #
  #   a = []
  #
  #   "It works. Does it?".each_sentence { |sentence| a << sentence }
  #
  #   a  #=> ["It works.", "Does it?"]
  #
  # Without a block, returns an enumerator.
  #
  def each_sentence(&block)
    return sentences.each unless block
    sentences.each(&block)
  end

end
