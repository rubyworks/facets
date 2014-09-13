covers 'facets/hash/fetch_nested'

test_case Hash do

  setup do
    @a = {'hello'=>{'world'=>42}}
    @b = {}
  end

  method :fetch_nested do

    test 'safe case' do
      @a['hello']['world'].assert == 42
      @a.fetch_nested(*['hello','world']).assert == 42
    end

    test 'dangerous case' do
      expect(NoMethodError){@b['hello']['world']}
      @b.fetch_nested(*['hello','world']).assert == nil
    end

  end

end
