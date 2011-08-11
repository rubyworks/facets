covers 'facets/symbol/op_div'

test_case Symbol do

  method :/ do

    test do
      (:merb / "string").assert == "merb/string"
      (:merb / :symbol).assert == "merb/symbol"
    end

  end

end

