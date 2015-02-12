covers 'facets/string/random'

test_case String do
  class_method :random do
    test do
      r = /^[0-9a-zA-Z]{32}$/
      a = String.random
      r.assert =~ a
    end

    test 'control the length' do
      r = /^[0-9a-zA-Z]{17}$/
      a = String.random(17)
      r.assert =~ a
    end

    test 'control the character_set' do
      r = /^[IAMBatman]{12}$/

      a = String.random(12, ['IAMBatman'.chars])
      r.assert =~ a
    end
  end
end

