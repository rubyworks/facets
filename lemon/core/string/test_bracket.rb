require 'facets/string/bracket'

Case String do

  Unit :bracket do
    'X'.bracket('#').assert == '#X#'
    'X'.bracket('x','!').assert == 'xX!'
    'X'.bracket('{','}').assert == '{X}'
    'X'.bracket('<').assert == '<X>'
    'X'.bracket('(').assert == '(X)'
    'X'.bracket('[').assert == '[X]'
    'X'.bracket('{').assert == '{X}'
  end

  Unit :braket! do
    a = 'X' ; a.bracket!('#')
    a.assert == '#X#'
    a = 'X' ; a.bracket!('x','!')
    a.assert == 'xX!'
    a = 'X' ; a.bracket!('{','}')
    a.assert == '{X}'
    a = 'X' ; a.bracket!('<')
    a.assert == '<X>'
    a = 'X' ; a.bracket!('(')
    a.assert == '(X)'
    a = 'X' ; a.bracket!('[')
    a.assert == '[X]'
    a = 'X' ; a.bracket!('{')
    a.assert == '{X}'
  end

  Unit :quote do
    ArgumentError.assert.raised?{ 'hi'.quote(1,2) }
  end

  Unit :quote => "default single quotes" do
    'hi'.quote.assert == %{'hi'}
  end

  Unit :quote => "single quotes" do
    'hi'.quote(:s).assert == %{'hi'}
    'hi'.quote(:single).assert == %{'hi'}
  end

  Unit :quote => "double quotes" do
    'hi'.quote(:d).assert == %{"hi"}
    'hi'.quote(:double).assert == %{"hi"}
  end

  Unit :quote => "back quotes" do
    'hi'.quote(:b).assert == %{`hi`}
    'hi'.quote(:back).assert == %{`hi`}
  end

end

