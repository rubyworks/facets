covers 'facets/exception/detail'

test_case Exception do

  method :detail do

    test "at least it runs" do
      err = ArgumentError.new("example error")
      err.detail
    end

  end

end

