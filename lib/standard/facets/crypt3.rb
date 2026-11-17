require 'securerandom'

# Crypt3 is a pure Ruby version of crypt(3), a salted one-way hashing
# of a password.
#
# Supported hashing algorithms are: md5, sha1, sha256, sha384, sha512, rmd160.
#
# Only the md5 hashing algorithm is standard and compatible with crypt(3),
# the others are not standard.
#
# Originally written by Poul-Henning Kamp (Beer-Ware License).
# Adapted by guillaume.pierronnet based on FreeBSD src/lib/libcrypt/crypt.c
#
# Copyright (c) 2002 Poul-Henning Kamp
# License: BSD-2-Clause

module Crypt3

  VERSION = '1.2.0'

  # Base 64 character set.
  ITOA64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  # A pure ruby version of crypt(3), a salted one-way hashing of a password.
  #
  # Automatically generates an 8-byte salt if none given.
  #
  #   Crypt3.crypt('password')           #=> "$1$xxxxxxxx$hash..."
  #   Crypt3.crypt('password', :sha256)  #=> "$1$xxxxxxxx$hash..."
  #
  # password - The phrase to encrypt. [String]
  # algo     - The algorithm to use. [Symbol]
  # salt     - Cryptographic salt, random if nil. [String]
  # magic    - The magic prefix. [String]
  #
  # Returns the cryptographic hash. [String]
  def self.crypt(password, algo = :md5, salt = nil, magic = '$1$')
    salt ||= generate_salt(8)

    case algo
    when :md5
      require "digest/md5"
    when :sha1
      require "digest/sha1"
    when :rmd160
      require "digest/rmd160"
    when :sha256, :sha384, :sha512
      require "digest/sha2"
    else
      raise(ArgumentError, "unknown algorithm: #{algo}")
    end

    digest_class = Digest.const_get(algo.to_s.upcase)

    m = digest_class.new
    m.update(password + magic + salt)

    mixin = digest_class.new.update(password + salt + password).digest
    password.length.times do |i|
      m.update(mixin[i % 16].chr)
    end

    i = password.length
    while i != 0
      if (i & 1) != 0
        m.update("\x00")
      else
        m.update(password[0].chr)
      end
      i >>= 1
    end

    final = m.digest

    1000.times do |i|
      m2 = digest_class.new
      m2.update((i & 1) != 0 ? password : final)
      m2.update(salt) if (i % 3) != 0
      m2.update(password) if (i % 7) != 0
      m2.update((i & 1) != 0 ? final : password)
      final = m2.digest
    end

    rearranged = ""
    [[0, 6, 12], [1, 7, 13], [2, 8, 14], [3, 9, 15], [4, 10, 5]].each do |a, b, c|
      v = final.getbyte(a) << 16 | final.getbyte(b) << 8 | final.getbyte(c)
      4.times do
        rearranged += ITOA64[v & 0x3f]
        v >>= 6
      end
    end

    v = final.getbyte(11)
    2.times do
      rearranged += ITOA64[v & 0x3f]
      v >>= 6
    end

    magic + salt + '$' + rearranged
  end

  # Check the validity of a password against a hashed string.
  #
  #   Crypt3.check('password', '$1$xxxxxxxx$hash...')  #=> true
  #
  # password - The phrase that was encrypted. [String]
  # hash     - The cryptographic hash. [String]
  # algo     - The algorithm used. [Symbol]
  #
  # Returns true if valid. [Boolean]
  def self.check(password, hash, algo = :md5)
    magic, salt = hash.split('$')[1, 2]
    magic = '$' + magic + '$'
    self.crypt(password, algo, salt, magic) == hash
  end

  # Generate a random salt of the given size, from SecureRandom.
  #
  #   Crypt3.generate_salt(8)  #=> "xK3d9Wq2"
  #
  # size - The size of the salt. [Integer]
  #
  # Returns random salt. [String]
  def self.generate_salt(size)
    (1..size).map { ITOA64[SecureRandom.random_number(ITOA64.size)] }.join
  end

end
