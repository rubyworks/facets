require 'facets/string/paragraphs'

class String

  # Returns an array of the sentences in a string.
  #
  #   "It works. Does it? Yes!".sentences  #=> ["It works.", "Does it?", "Yes!"]
  #
  # A sentence ends with a period, question mark, exclamation mark or
  # ellipsis, along with any quotation marks or brackets that close it,
  # followed by whitespace or the end of the text. So the period in a
  # number or a file name doesn't end one.
  #
  #   "Pi is 3.14. See pi.rb.".sentences  #=> ["Pi is 3.14.", "See pi.rb."]
  #
  #   'He said "Stop." Then he left.'.sentences
  #   #=> ["He said \"Stop.\"", "Then he left."]
  #
  # A blank line ends a sentence too, so a heading with no period is a
  # sentence of its own. The full-width marks of Chinese and Japanese end
  # a sentence without needing a space after them.
  #
  # This goes by punctuation alone and knows nothing of any language, so
  # an abbreviation is taken for the end of a sentence:
  #
  #   "Dr. Who is in.".sentences  #=> ["Dr.", "Who is in."]
  #
  # CREDIT: Trans
  #
  def sentences
    close = %q{["'”’»)\]]*}
    re = /.+?(?:[.!?…]+#{close}(?=\s|\z)|[。！？]+[」』”’]*|\z)/m
    paragraphs.flat_map do |para|
      para.scan(re).map{ |sentence| sentence.strip }.reject{ |sentence| sentence.empty? }
    end
  end

end
