covers 'facets/string/underscore'

test_case String do

  method :underscore do

    test "from camelcase" do
      "SnakeCase".underscore.assert == "snake_case"
    end

    test "containing a dash" do
      "Snake-Case".underscore.assert == "snake_case"
    end

    test "containing spaces" do
      "Snake Case".underscore.assert == "snake_case"
    end

  end

end
