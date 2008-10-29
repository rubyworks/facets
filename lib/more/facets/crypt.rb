# = Crypt
#
# A pure ruby version of crypt(3), a salted one-way hashing of a password.
#
# == History
#
#   Adapted by guillaume__dot__pierronnet_at__laposte__dot_net based on
#   * http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/325204/index_txt
#   which is based on FreeBSD src/lib/libcrypt/crypt.c 1.2
#   * http://www.freebsd.org/cgi/cvsweb.cgi/~checkout~/src/lib/libcrypt/crypt.c?rev=1.2&content-type=text/plain
#
#   [Original License]
#
#   "THE BEER-WARE LICENSE" (Revision 42):
#   <phk@login.dknet.dk> wrote this file.  As long as you retain this notice you
#   can do whatever you want with this stuff. If we meet some day, and you think
#   this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
#
# == Authors
#
# * Poul-Henning Kamp
#
# == Copying
#
# Copyright (c) 2002 Poul-Henning Kamp
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/string/xor.rb'

# = Crypt
#
# A pure ruby version of crypt(3), a salted one-way hashing of a password.
#
module Crypt

  ITOA64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  # A pure ruby version of crypt(3), a salted one-way hashing of a password.
  #
  # Supported hashing algorithms are: md5, sha1, sha256, sha384, sha512, rmd160.
  #
  # Only the md5 hashing algorithm is standard and compatible with crypt(3), the others
  # are not standard.
  #
  # Automatically generate a 8-bytes salt if nil.
  #
  # Output a length hashed and salted string with size of
  # magic.size + salt.size + 23.

  def self.crypt(password, algo = :md5, salt = nil, magic='$1$')

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
      raise(ArgumentError, "unknown algorithm")
    end
    digest_class = Digest.const_get(algo.to_s.upcase)

    # The password first, since that is what is most unknown. Then our magic string. Then the raw salt.
    m = digest_class.new
    m.update(password + magic + salt)

    # Then just as many characters of the MD5(pw,salt,pw)
    mixin = digest_class.new.update(password + salt + password).digest
    password.length.times do |i|
      m.update(mixin[i % 16].chr)
    end

    # Then something really weird...
    # Also really broken, as far as I can tell.  -m
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

    # and now, just to make sure things don't run too fast
    1000.times do |i|
      m2 = digest_class.new

      if (i & 1) != 0
        m2.update(password)
      else
        m2.update(final)
      end

      if (i % 3) != 0
        m2.update(salt)
      end
      if (i % 7) != 0
        m2.update(password)
      end

      if (i & 1) != 0
        m2.update(final)
      else
        m2.update(password)
      end

      final = m2.digest
    end

    # This is the bit that uses to64() in the original code.

    rearranged = ""

    [ [0, 6, 12], [1, 7, 13], [2, 8, 14], [3, 9, 15], [4, 10, 5] ].each do |a, b, c|

      v = final[a] << 16 | final[b] << 8 | final[c]

      4.times do
        rearranged += ITOA64[v & 0x3f].chr
        v >>= 6
      end
    end

    v = final[11]

    2.times do
      rearranged += ITOA64[v & 0x3f].chr
      v >>= 6
    end

    magic + salt + '$' + rearranged
  end


  # check the validity of a password against an hashed string

  def self.check(password, hash, algo = :md5)
    magic, salt = hash.split('$')[1,2]
    magic = '$' + magic + '$'
    self.crypt(password, algo, salt, magic) == hash
  end


  # generate a +size+ length random salt

  def self.generate_salt(size)
    (1..size).collect { ITOA64[rand(ITOA64.size)].chr }.join("")
  end
end

