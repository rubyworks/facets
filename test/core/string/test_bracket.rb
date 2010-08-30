covers 'facets/string/bracket'

testcase String do

  unit :bracket do
    'X'.bracket('#').assert == '#X#'
    'X'.bracket('x','!').assert == 'xX!'
    'X'.bracket('{','}').assert == '{X}'
    'X'.bracket('<').assert == '<X>'
    'X'.bracket('(').assert == '(X)'
    'X'.bracket('[').assert == '[X]'
    'X'.bracket('{').assert == '{X}'
  end

  unit :bracket! do
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

