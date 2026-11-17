covers 'facets/crypt3'

test_case Crypt3 do

  class_method :crypt do

    # Hashes made by crypt(3) and by Apache's htpasswd, from the Crypt3
    # gem's own tests.
    known = {
      ' '                                 => '$1$yiiZbNIH$YiCsHZjcTkYd31wkgW8JF.',
      'pass'                              => '$1$YeNsbWdH$wvOF8JdqsoiLix754LTW90',
      '____fifteen____'                   => '$1$s9lUWACI$Kk1jtIVVdmT01p0z3b/hw1',
      '____sixteen_____'                  => '$1$dL3xbVZI$kkgqhCanLdxODGq14g/tW1',
      '____seventeen____'                 => '$1$NaH5na7J$j7y8Iss0hcRbu3kzoJs5V.',
      '__________thirty-three___________' => '$1$HO7Q6vzJ$yGwp2wbL5D7eOVzOmxpsy.'
    }

    test "gives the same md5 hashes as crypt(3)" do
      known.each do |password, hash|
        salt = hash.split('$')[2]
        Crypt3.crypt(password, :md5, salt).assert == hash
      end
    end

    test "gives the same hash as Apache for the apr1 magic" do
      Crypt3.crypt('apache', :md5, 'J.w5a/..', '$apr1$').assert == '$apr1$J.w5a/..$IW9y6DR0oO/ADuhlMF5/X1'
    end

    test "gives the same hash for the same password and salt" do
      [:md5, :sha1, :sha256, :sha384, :sha512].each do |algo|
        Crypt3.crypt('secret', algo, 'abcdefgh').assert == Crypt3.crypt('secret', algo, 'abcdefgh')
      end
    end

    test "gives a different hash for each algorithm" do
      hashes = [:md5, :sha1, :sha256, :sha384, :sha512].map { |algo| Crypt3.crypt('secret', algo, 'abcdefgh') }
      hashes.uniq.size.assert == 5
    end

    test "starts with the magic and the salt" do
      Crypt3.crypt('secret', :sha256, 'abcdefgh').assert.start_with?('$1$abcdefgh$')
    end

    test "makes a random 8 character salt when given none" do
      a = Crypt3.crypt('secret')
      b = Crypt3.crypt('secret')
      a.refute == b
      a.split('$')[2].size.assert == 8
      Crypt3.check('secret', a).assert == true
    end

    test "raises an error for an unknown algorithm" do
      ArgumentError.assert.raised? do
        Crypt3.crypt('secret', :nope)
      end
    end

  end

  class_method :check do

    test "is true for the password that was hashed" do
      Crypt3.check('pass', '$1$YeNsbWdH$wvOF8JdqsoiLix754LTW90').assert == true
    end

    test "is false for another password" do
      Crypt3.check('Pass', '$1$YeNsbWdH$wvOF8JdqsoiLix754LTW90').assert == false
    end

    test "reads the magic from the hash" do
      Crypt3.check('apache', '$apr1$J.w5a/..$IW9y6DR0oO/ADuhlMF5/X1').assert == true
    end

    test "checks against the algorithm given" do
      hash = Crypt3.crypt('secret', :sha512)
      Crypt3.check('secret', hash, :sha512).assert == true
      Crypt3.check('secret', hash, :md5).assert == false
    end

  end

  class_method :generate_salt do

    test "gives a salt of the size asked for" do
      Crypt3.generate_salt(8).size.assert == 8
      Crypt3.generate_salt(16).size.assert == 16
    end

    test "uses only the crypt(3) base 64 characters" do
      Crypt3.generate_salt(200).delete(Crypt3::ITOA64).assert == ''
    end

  end

end
