covers 'facets/string/paragraphs'
covers 'facets/string/each_paragraph'

test_case String do

  method :paragraphs do

    test "blank lines separate paragraphs" do
      "One.\n\nTwo.".paragraphs.assert == ["One.", "Two."]
    end

    test "the lines of a paragraph are kept" do
      "One.\nStill one.\n\nTwo.".paragraphs.assert == ["One.\nStill one.", "Two."]
    end

    test "several blank lines are one separator" do
      "a\n\n\n\nb".paragraphs.assert == ["a", "b"]
    end

    test "a line of only whitespace is blank" do
      "a\n \t\nb".paragraphs.assert == ["a", "b"]
    end

    test "blank lines at the start and end are ignored" do
      "\n\n a\n\nb \n\n".paragraphs.assert == ["a", "b"]
    end

    test "Windows line endings" do
      "a\r\n\r\nb\r\n".paragraphs.assert == ["a", "b"]
    end

    test "one paragraph" do
      "just this".paragraphs.assert == ["just this"]
    end

    test "an empty or blank string has none" do
      "".paragraphs.assert == []
      " \n\n ".paragraphs.assert == []
    end

    test "the string is not changed" do
      s = "a\n\nb"
      s.paragraphs
      s.assert == "a\n\nb"
    end

  end

  method :each_paragraph do

    test do
      a = []
      "One.\n\nTwo.".each_paragraph{ |para| a << para }
      a.assert == ["One.", "Two."]
    end

    test "without a block gives an enumerator" do
      e = "One.\n\nTwo.".each_paragraph
      e.assert.is_a?(Enumerator)
      e.to_a.assert == ["One.", "Two."]
    end

  end

end
