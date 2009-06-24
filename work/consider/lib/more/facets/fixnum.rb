#--
# Fixnum Constants
# Copyright (c) 2005 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.
#++

# = Fixnum Constants
#
# Constants providing the numerical limitations of Fixnum class.
#
# == Synopsis
#
#   require 'mega/fixnum-constants'
#
#   puts Fixnum::MAX  #=>
#

class Fixnum
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 8
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

# TODO

=begin testing

  require 'test/unit'

  class TC_FixnumConst < Test::Unit::TestCase

    def test_01
    end

  end

=end
