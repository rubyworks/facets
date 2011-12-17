# = Equitable
#
# This mixin provides methods of equality based
# on a single #identity method which must return
# a list of accessors used as the identity keys.
#
# It also provides a "shortcut" for creating the
# #identity method based on given accessors and returns
# the Equitable module for inclusion.
#
#   include Equitable(:a, :b)
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
module Equitable

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
  # the Equitable module for inclusion.
  #
  #  include Equitable(:a, :b)
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

  def Equitable(*accessors)
    Equitable.identify(self, *accessors)
  end

end

