require 'digest'
require 'securerandom'

module Digest

  module Instance
    # The digest of +str+ followed by +salt+, with the salt appended.
    # With +salt+ :auto, the salt is +digest_length+ random bytes from
    # SecureRandom.
    #
    # CREDIT: Guido De Rosa
    def salted_digest(str='', salt=:auto)
      if salt == :auto
        salt = SecureRandom.random_bytes(digest_length)
      end
      digest(str + salt) + salt
    end

    # CREDIT: Guido De Rosa
    def salted_hexdigest(str, salt)
      Digest.hexencode(salted_digest(str, salt))
    end

    # CREDIT: Guido De Rosa
    def salted_base64digest(str, salt)
      [salted_digest(str, salt)].pack('m0')
    end
  end

  class Class
    # CREDIT: Guido De Rosa
    def self.salted_digest(str, salt=:auto, *args)
      new(*args).salted_digest(str, salt)
    end 

    # CREDIT: Guido De Rosa
    def self.salted_hexdigest(str, salt=:auto, *args)
      new(*args).salted_hexdigest(str, salt)
    end

    # CREDIT: Guido De Rosa
    def self.salted_base64digest(str, salt=:auto, *args)
      new(*args).salted_base64digest(str, salt)
    end
  end

end

