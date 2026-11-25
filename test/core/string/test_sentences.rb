covers 'facets/string/sentences'
covers 'facets/string/each_sentence'

test_case String do

  method :sentences do

    test "periods, question marks and exclamation marks" do
      "It works. Does it? Yes!".sentences.assert == ["It works.", "Does it?", "Yes!"]
    end

    test "a period inside a number or a name doesn't end a sentence" do
      "Pi is 3.14. See pi.rb.".sentences.assert == ["Pi is 3.14.", "See pi.rb."]
    end

    test "closing quotation marks and brackets stay with their sentence" do
      'He said "Stop." Then he left.'.sentences.assert == ['He said "Stop."', "Then he left."]
      "(See below.) Next.".sentences.assert == ["(See below.)", "Next."]
      "\u201cStop.\u201d He left.".sentences.assert == ["\u201cStop.\u201d", "He left."]
    end

    test "marks that come together" do
      "Really?! Yes.".sentences.assert == ["Really?!", "Yes."]
      "Wait... what?".sentences.assert == ["Wait...", "what?"]
      "Wait\u2026 what?".sentences.assert == ["Wait\u2026", "what?"]
    end

    test "text without a final mark is a sentence" do
      "One. and the rest".sentences.assert == ["One.", "and the rest"]
      "no stop at all".sentences.assert == ["no stop at all"]
    end

    test "a sentence can run over lines" do
      "One\ntwo. Three.".sentences.assert == ["One\ntwo.", "Three."]
    end

    test "a blank line ends a sentence" do
      "A Heading\n\nFirst. Second.".sentences.assert == ["A Heading", "First.", "Second."]
    end

    test "full-width marks need no space after them" do
      "\u3053\u308c\u3002\u3042\u308c\u3002".sentences.assert == ["\u3053\u308c\u3002", "\u3042\u308c\u3002"]
    end

    test "abbreviations are taken for sentence ends" do
      "Dr. Who is in.".sentences.assert == ["Dr.", "Who is in."]
    end

    test "an empty or blank string has none" do
      "".sentences.assert == []
      " \n ".sentences.assert == []
    end

  end

  method :each_sentence do

    test do
      a = []
      "It works. Does it?".each_sentence{ |sentence| a << sentence }
      a.assert == ["It works.", "Does it?"]
    end

    test "without a block gives an enumerator" do
      e = "It works. Does it?".each_sentence
      e.assert.is_a?(Enumerator)
      e.to_a.assert == ["It works.", "Does it?"]
    end

  end

end
