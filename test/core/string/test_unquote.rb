covers 'facets/string/unquote'

tests String do

  unit :unquote do
    "'here'".unquote.assert == "here"
  end

end
