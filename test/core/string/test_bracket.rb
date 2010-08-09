Covers 'facets/string/bracket'

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

  Unit :bracket! do
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

end

