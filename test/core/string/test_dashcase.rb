covers 'facets/string/dashcase'

test_case String do

  method :dashcase do

    test "from camelcase" do
      "DashCase".dashcase.assert == "dash-case"
    end

    test "containing an underscore" do
      "Dash_Case".dashcase.assert == "dash-case"
    end

    test "containing spaces" do
      "Dash Case".dashcase.assert == "dash-case"
    end

  end

end
