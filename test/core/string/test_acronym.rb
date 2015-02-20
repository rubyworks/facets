covers 'facets/string/acronym'

test_case String do

  method :acronym do
    test do
      'abc'.acronym.assert == 'a'
      'abc def'.acronym.assert == 'ad'
      'abc def ghi'.acronym.assert == 'adg'
    end
  end

end

