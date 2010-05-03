require 'facets/string/each_word.rb'

Case String do

  Unit :each_word do
    a = []
    i = "this is a test"
    i.each_word{ |w| a << w }
    a.assert == ['this', 'is', 'a', 'test']
  end

end

