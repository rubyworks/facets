covers 'facets/exception/add_context'

test_case Exception do

  method :add_context do
    def exception
      0/0 rescue $!
    end

    test 'errors if non-hash' do
      exc = exception()
      RuntimeError.assert.raised? {
        exc.add_context("here's some context")
      }
    end

    test 'merges hashes' do
      exc = exception()
      exc.add_context(file: __FILE__)
      exc.add_context(test_name: 'merges hashes')
      exc.context.assert == {
        file: __FILE__,
        test_name: 'merges hashes',
      }
    end
  end
end
