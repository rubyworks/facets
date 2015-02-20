covers 'facets/string/crypt'

test_case String do

  method :crypt do
    test do
      "abc".crypt('ZZ').assert.start_with?('ZZ')
    end

    test do
      encrypted = "abc".crypt
      salt = encrypted[0..1]
      "abc".crypt(salt).assert == encrypted
    end
  end
end

