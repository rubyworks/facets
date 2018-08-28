covers 'facets/string/words'

test_case String do

  method :words do

    test do
      x = "a b c\nd e"
      x.words.assert == ['a','b','c','d','e']
    end

    test do
      x = "ab cd\nef"
      x.words.assert == ['ab','cd','ef']
    end

    test do
      x = "ab cd \n ef-gh"
      x.words.assert == ['ab','cd','ef-gh']
    end

  end
  
  method :words_without_punctuation do
    
    test do
      # English
      x = "How?? I don't believe you!!!"
      x.words_without_punctuation.assert == ['How', 'I', "don't", 'believe', 'you']
      x = 'Slowly, grudgingly he said: "This has to stop."'
      x.words_without_punctuation.assert == ['Slowly', 'grudgingly', 'he', 'said', 'This', 'has', 'to', 'stop']
    end
    
    test do
      # French
      x = "« Bonjour ! J'ai rendezvous avec mademoiselle Dupont-Fleury ! »"
      x.words_without_punctuation.assert == ['Bonjour', "J'ai", "rendezvous", "avec", "mademoiselle", "Dupont-Fleury"]
    end
    
    test do
      # Spanish
      x = "«¡María, te amo!», exclamó Juan. … «¿Por qué me sigues mintiendo?"
      x.words_without_punctuation.assert == ['María', 'te', 'amo', 'exclamó', 'Juan', 'Por', 'qué', 'me', 'sigues', 'mintiendo']
    end
    
    test do
      # Italian
      x = 'Alcune persone scrivono al computer; altre con la penna: io con le due.'
      x.words_without_punctuation.assert == ['Alcune', 'persone', 'scrivono', 'al', 'computer', 'altre', 'con', 'la', 'penna', 'io', 'con', 'le', 'due']
    end
    
    test do
      # German
      x = '“chevron,” „französische“ Anführungszeichen'
      x.words_without_punctuation.assert == ['chevron', 'französische', 'Anführungszeichen']
    end
    
    test do
      # Russian
      x = '"А ты прав." — сказал он, — "Я великолепен!".'
      x.words_without_punctuation.assert == ['А', 'ты', 'прав', 'сказал', 'он', 'Я', 'великолепен']
    end
  end

end
