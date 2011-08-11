covers 'facets/string/bracket'

test_case String do

  method :bracket do
    test do
      'X'.bracket('#').assert == '#X#'
      'X'.bracket('x','!').assert == 'xX!'
      'X'.bracket('{','}').assert == '{X}'
      'X'.bracket('<').assert == '<X>'
      'X'.bracket('(').assert == '(X)'
      'X'.bracket('[').assert == '[X]'
      'X'.bracket('{').assert == '{X}'
    end
  end

  method :bracket! do
    test do
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

end

