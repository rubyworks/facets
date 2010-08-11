covers 'facets/string/underscore'

tests String do

  unit :underscore => "from camelcase" do
    "SnakeCase".underscore.assert == "snake_case"
  end

  unit :underscore => "containing a dash" do
    "Snake-Case".underscore.assert == "snake_case"
  end

  unit :underscore => "containing double colons" do
    "SnakeCase::Errors".underscore.assert == "snake_case/errors"
  end

end
