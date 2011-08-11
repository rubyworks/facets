covers 'facets/string/each_word.rb'

test_case String do

  method :each_word do

    test do
      a = []
      i = "this is a test"
      i.each_word{ |w| a << w }
      a.assert == ['this', 'is', 'a', 'test']
    end

  end

end

