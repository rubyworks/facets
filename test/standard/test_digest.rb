covers 'facets/digest'

test_case Digest::Instance do

  method :salted_digest do

    test "is the digest of the string and salt, with the salt appended" do
      d = Digest::SHA256.new.salted_digest('secret', 'pepper')
      d.assert == Digest::SHA256.digest('secretpepper') + 'pepper'
    end

    test "makes a random salt the length of the digest" do
      a = Digest::SHA256.new.salted_digest('secret')
      b = Digest::SHA256.new.salted_digest('secret')
      a.bytesize.assert == 64
      a.refute == b
      a.byteslice(0, 32).assert == Digest::SHA256.digest('secret' + a.byteslice(32, 32))
    end

  end

  method :salted_hexdigest do

    test do
      Digest::SHA256.new.salted_hexdigest('secret', 'pepper').assert ==
        Digest.hexencode(Digest::SHA256.digest('secretpepper') + 'pepper')
    end

  end

end
