class String

  # Returns an array of characters.
  #
  #   "abc 123".words  #=> ["abc","123"]
  #
  def words
    self.split(/\s+/)
  end
  
  # Returns an array of words in the commonly-understood sense (not including punctuation).
  # This takes into account international punctuation characters as well as English ones.
  # 
  #     'Slowly, grudgingly he said: "This has to stop."'.words
  #      => ["Slowly", "grudgingly", "he", "said", "This", "has", "to", "stop"]
  def words_without_punctuation
    s = self.dup
    s.gsub!(/[.?¿¡…!,:：;—"。？！、‘“”„«»〈〉《》，\/\[\]]/, ' ')
    s.gsub!('- ', ' ')
    s.squeeze!(" ")
    s.strip.split(" ")
  end  
end

