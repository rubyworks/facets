# = OpenObject
#
# OpenObject is very similar to Ruby's own OpenStruct, but it offers some
# useful advantages. With OpenStruct slots with the same name's as predefined
# Object methods can not be used. With OpenObject any slot can be defined,
# OpendObject is also a bit faster becuase it is based on a Hash, not
# method signitures.
#
# Because OpenObject is a subclass of Hash, it can do just about
# everything a Hash can do, except that most public methods have been
# made protected and thus available only internally or via #send.
#
# OpenObject will also clobber any method for which a slot is defined.
# Even generally very important methods can be clobbered, like
# instance_eval. So be aware of this. OpenObject should be used in well
# controlled scenarios.
#
# If you wish to pass an OpenObject to a routine that normal takes a Hash,
# but are uncertain it can handle the distictions properly  you can convert
# easily to a Hash using #to_hash! and the result will automatically be
# converted back to an OpenObject on return.
#
#   o = OpenObject.new(:a=>1,:b=>2)
#   o.as_hash!{ |h| h.update(:a=>6) }
#   o #=> #<OpenObject {:a=>6,:b=>2}>
#
# Finally, unlike a regular Hash, all OpenObject's keys are symbols and
# all keys are converted to such using #to_sym on the fly.
#
# == Authors
#
# * Thomas Sawyer
# * George Moschovitis
#
# == Copying
#
# Copyright (c) 2005 Thomas Sawyer, George Moschovitis
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/hash/to_h'
require 'facets/hash/to_proc'
require 'facets/kernel/object_class'
require 'facets/kernel/object_hexid'

# = OpenObject
#
# OpenObject is very similar to Ruby's own OpenStruct, but it offers some
# useful advantages. With OpenStruct slots with the same name's as predefined
# Object methods can not be used. With OpenObject any slot can be defined,
# OpendObject is also a bit faster becuase it is based on a Hash, not
# method signitures.
#
# Because OpenObject is a subclass of Hash, it can do just about
# everything a Hash can do, except that most public methods have been
# made protected and thus available only internally or via #send.
#
# OpenObject will also clobber any method for which a slot is defined.
# Even generally very important methods can be clobbered, like
# instance_eval. So be aware of this. OpenObject should be used in well
# controlled scenarios.
#
# If you wish to pass an OpenObject to a routine that normal takes a Hash,
# but are uncertain it can handle the distictions properly  you can convert
# easily to a Hash using #to_hash! and the result will automatically be
# converted back to an OpenObject on return.
#
#   o = OpenObject.new(:a=>1,:b=>2)
#   o.as_hash!{ |h| h.update(:a=>6) }
#   o #=> #<OpenObject {:a=>6,:b=>2}>
#
# Finally, unlike a regular Hash, all OpenObject's keys are symbols and
# all keys are converted to such using #to_sym on the fly.

class OpenObject < Hash

  PUBLIC_METHODS = /(^__|^instance_|^object_|^\W|^as$|^send$|^class$|\?$)/

  protected(*public_instance_methods.select{ |m| m !~ PUBLIC_METHODS })

  def self.[](hash=nil)
    new(hash)
  end

old_verbose = $VERBOSE
$VERBOSE = false  # shut warnings up while redefining these methods.

  # Inititalizer for OpenObject is slightly differnt than that of Hash.
  # It does not take a default parameter, but an initial priming Hash
  # as with OpenStruct. The initializer can still take a default block
  # however. To set the degault value use ++#default!(value)++.
  #
  #   OpenObject(:a=>1).default!(0)

  def initialize( hash=nil, &yld )
    super( &yld )
    hash.each { |k,v| define_slot(k,v) } if hash
  end

  def initialize_copy( orig )
    orig.each { |k,v| define_slot(k,v) }
  end

  # Object inspection. (Careful, this can be clobbered!)

  def inspect
    "#<#{object_class}:#{object_hexid} #{super}>"
  end

  # Conversion methods. (Careful, these can be clobbered!)

  def to_a() super end

  def to_h() {}.update(self) end
  def to_hash() {}.update(self) end

  def to_proc() super  end

  def to_openobject() self end

  # Iterate over each key-value pair. (Careful, this can be clobbered!)

  def each(&yld) super(&yld) end

  # Merge one OpenObject with another creating a new OpenObject.

  def merge( other )
    d = dup
    d.send(:update, other)
    d
  end

  # Update this OpenObject with another.

  def update( other )
    begin
      other.each { |k,v| define_slot(k,v) }
    rescue
      other = other.to_h
      retry
    end
  end

  #

  def delete(key)
    super(key.to_sym)
  end

  # Set the default value.

  def default!(default)
    self.default = default
  end

  # Preform inplace action on OpenObject as if it were a regular Hash.
  #--
  # TODO Not so sure about #as_hash!. For starters if it doesn't return a hash it will fail.
  # TODO Replace by using #as(Hash). Perhaps as_hash and as_object shortcuts? Why?
  #++

  def as_hash!(&yld)
    replace(yld.call(to_hash))
  end

  # Check equality. (Should equal be true for Hash too?)

  def ==( other )
    return false unless OpenObject === other
    super(other) #(other.send(:table))
  end

  def []=(k,v)
    protect_slot(k)
    super(k.to_sym,v)
  end

  def [](k)
    super(k.to_sym)
  end

  protected

    def store(k,v)
      super(k.to_sym,v)
      define_slot(k)
    end

    def fetch(k,*d,&b)
      super(k.to_sym,*d,&b)
    end

    def define_slot( key, value=nil )
      protect_slot( key )
      self[key.to_sym] = value
    end

    def protect_slot( key )
      (class << self; self; end).class_eval {
        protected key rescue nil
      }
    end

    def method_missing( sym, arg=nil, &blk)
      type = sym.to_s[-1,1]
      key = sym.to_s.sub(/[=?!]$/,'').to_sym
      if type == '='
        define_slot(key,arg)
      elsif type == '!'
        define_slot(key,arg)
        self
      else
        self[key]
      end
    end

$VERBOSE = old_verbose

end

# Core Extensions

class NilClass
  # Nil converts to an empty OpenObject.

  def to_openobject
    OpenObject.new
  end
end

class Hash
  # Convert a Hash into an OpenObject.

  def to_openobject
    OpenObject[self]
  end
end

class Proc
  # Translates a Proc into an OpenObject. By droping an OpenObject into
  # the Proc, the resulting assignments incured as the procedure is
  # evaluated produce the OpenObject. This technique is simlar to that
  # of MethodProbe.
  #
  #   p = lambda { |x|
  #     x.word = "Hello"
  #   }
  #   o = p.to_openobject
  #   o.word #=> "Hello"
  #
  # NOTE The Proc must have an arity of one --no more and no less.

  def to_openobject
    raise ArgumentError, 'bad arity for converting Proc to openobject' if arity != 1
    o = OpenObject.new
    self.call( o )
    o
  end
end

