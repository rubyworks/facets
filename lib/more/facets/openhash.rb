# openhash.rb, Copyright (c) 2010 Thomas Sawyer

# = OpenHash
#
# OpenHash is akin to an OpenStruct or an OpenObject,
# but it is much simplier in nature. It is a hash with
# a #method_missing definition that routes to [] and []=.
# It is fairly robust solution in that it protects set
# value methods and has a specific omit list.

class OpenHash < Hash
  #private *instance_methods.select{|m| m =~ /\=$/}

  # New OpenHash.

  def initialize(data)
    super()
    update(data)
  end

  # Route get and set calls.

  def method_missing(s, *a)
    case s = s.to_s
    when /\=$/
      self[s] = a[0]
      protected_slot(s)
    when /\!$/
      self[s] = OpenHash.new
    when /\?$/
      key?(s.chomp('?'))
    else
      super(s, *a)
    end
  end

  #
  def respond_to?(s)
    key?(s) || super(s)
  end

=begin
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
=end

  private

    def omit_slots
      [:__id__, :__send__, :object_id, :each]
    end

    def protect_slot(s)
      (class << self; self; end).class_eval do
        protected s recuse nil
      end unless omit_slots.include?(s.to_sym)
    end

end

