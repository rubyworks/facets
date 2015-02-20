covers 'facets/string/ascii_only'

test_case String do

  method :ascii_only do
    test 'without any non-ascii' do
      'abc'.ascii_only.assert == 'abc'
    end

    test 'with non-ascii' do
     '中文123'.ascii_only.assert == '123'
    end

    test 'with non-ascii when passed alt' do
      'abc'.ascii_only('!').assert == 'abc'
    end

    test 'with non-ascii when passed alt' do
      '中文123'.ascii_only('!').assert == '!!123'
    end
  end

  method :ascii_only! do
    test 'without any non-ascii' do
      s = 'abc'
      s.ascii_only!
      s.assert == 'abc'
    end

    test 'with non-ascii' do
      s = '中文123'
      s.ascii_only!
      s.assert == '123'
    end

    test 'without any non-ascii' do
      s = 'abc'
      s.ascii_only!('!')
      s.assert == 'abc'
    end

    test 'with non-ascii' do
      s = '中文123'
      s.ascii_only!('!')
      s.assert == '!!123'
    end

  end

end

