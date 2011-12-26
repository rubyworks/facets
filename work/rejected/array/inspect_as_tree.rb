class Array
  # Inspect a (usually nested) Array vertically with indentation to show the nesting.
  # 
  #   [:sentence, [:noun_phrase, [:determiner, "the"], [:noun, "man"], [:prepositional_phrase, [:preposition, "in"], [:noun_phrase, [:determiner, "the"], [:noun, "street"]]]], [:verb, "grows"], [:noun_phrase, [:noun, "avocados"]]].inspect_as_tree
  #
  # gives:
  # :sentence
  #     :noun_phrase
  #         :determiner
  #         "the"
  #         :noun
  #         "man"
  #         :prepositional_phrase
  #             :preposition
  #             "in"
  #             :noun_phrase
  #                 :determiner
  #                 "the"
  #                 :noun
  #                 "street"
  #     :verb
  #     "grows"
  #     :noun_phrase
  #         :noun
  #         "avocados"
  def inspect_as_tree(indentation = 4, level = 0)
    tree = ""
    
    self.each do |item|
      if item.respond_to?(:inspect_as_tree)
        tree << item.inspect_as_tree(indentation, level + indentation)
      else
        tree << "#{" " * level}#{item.inspect}\n"
      end
    end
    
    return tree
  end
end

# A larger example:
puts [:sentence, [:noun_phrase, [:determiner, "the"], [:noun, "monster"], [:prepositional_phrase, [:preposition, "in"], [:noun_phrase, [:determiner, "the"], [:noun, "man"]]]], [:verb, "grows"], [:noun_phrase, [:noun, "avocados"], [:prepositional_phrase, [:preposition, "in"], [:noun_phrase, [:determiner, "the"], [:noun, "street"]]]]].inspect_as_tree
# >> :sentence
# >>     :noun_phrase
# >>         :determiner
# >>         "the"
# >>         :noun
# >>         "monster"
# >>         :prepositional_phrase
# >>             :preposition
# >>             "in"
# >>             :noun_phrase
# >>                 :determiner
# >>                 "the"
# >>                 :noun
# >>                 "man"
# >>     :verb
# >>     "grows"
# >>     :noun_phrase
# >>         :noun
# >>         "avocados"
# >>         :prepositional_phrase
# >>             :preposition
# >>             "in"
# >>             :noun_phrase
# >>                 :determiner
# >>                 "the"
# >>                 :noun
# >>                 "street"
