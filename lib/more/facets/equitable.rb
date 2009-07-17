# = Equatable
#
# This mixin provides methods of equality based
# on a single #identity method which must return
# a list of accessors used as the identity keys.
#
# It also provides a "shortcut" for creating the
# #identity method based on given accessors and returns
# the Equatable module for inclusion.
#
#   include Equatable(:a, :b)
#
# is equivalent to including a module containing:
#
#   def ==(other)
#     self.a == other.a && self.b == other.b
#   end
#
#   def eql?(other)
#     self.a.eql?(other.a) && self.b.eql?(other.b)
#   end
#
#   def hash()
#     self.a.hash ^ self.b.hash
#   end
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2004 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


# = Equatable
#
# This mixin provides methods of equality based
# on a single #identity method which must return
# a list of accessors used as the identity keys.
#
# It also provides a "shortcut" for creating the
# #identity method based on given accessors and returns
# the Equatable module for inclusion.
#
#   include Equatable(:a, :b)
#
# is equivalent to including a module containing:
#
#   def ==(other)
#     self.a == other.a && self.b == other.b
#   end
#
#   def eql?(other)
#     self.a.eql?(other.a) && self.b.eql?(other.b)
#   end
#
#   def hash()
#     self.a.hash ^ self.b.hash
#   end
#
module Equatable

  def self.identify(base, *accessors)
    base.send(:define_method, :identity){ accessors }
    self
  end

  def ==(o)
    identity.all?{ |a| send(a) == o.send(a) }
  end

  def eql?(o)
    identity.all?{ |a| send(a).eql?(o.send(a)) }
  end

  def hash
    identity.inject(0){ |memo, a| memo ^ send(a).hash }
  end

end

class Module

  # This function provided a "shortcut" for creating the
  # #identity method based on given accessors and returns
  # the Equatable module for inclusion.
  #
  #  include Equatable(:a, :b)
  #
  # is equivalent to including a module containing:
  #
  #   def ==(other)
  #     self.a == other.a && self.b == other.b
  #   end
  #
  #   def eql?(other)
  #     self.a.eql?(other.a) && self.b.eql?(other.b)
  #   end
  #
  #   def hash()
  #     self.a.hash ^ self.b.hash
  #   end
  #

  def Equatable(*accessors)
    Equatable.identify(self, *accessors)
  end

end

