# = OpenHash
#
# OpenHash is akin to an OpenStruct or an OpenObject,
# but it is much simplier in nature. It is a hash with
# an method_missing definition that routes to [] and []=.
#
# == Author
#
# * Trans

# = OpenHash
#
# OpenHash is akin to an OpenStruct or an OpenObject,
# but it is much simplier in nature. It is a hash with
# an method_missing definition that routes to [] and []=.
#
class OpenHash < Hash
  #private *instance_methods.select{|m| m !~ /^__/}

  # New OpenHash.

  def initialize(data)
    super()
    update(data)
  end

  # Route get and set calls.

  def method_missing(s, *a)
    if s =~ /=$/
      self[s] = a[0]
    elsif a.empty?
      self[s]
    else
      super
    end
  end

end
