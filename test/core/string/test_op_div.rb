covers 'facets/string/op_div'

test_case String do

  method :/ do

    test do
      ('merb' / 'string').assert == "merb/string"
      ('merb' / :symbol).assert == "merb/symbol"
    end

  end

end

