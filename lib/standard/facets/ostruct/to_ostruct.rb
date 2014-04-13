require 'ostruct'

class OpenStruct
  #
  def to_ostruct
    self
  end
end

class Hash
  # Turns a hash into a generic object using an OpenStruct.
  #
  #     o = {'a' => 1}.to_ostruct
  #     o.a  #=> 1
  #
  def to_ostruct
    OpenStruct.new(self)
  end

  ## Recursively converts a Hash object to an OpenStruct object.
  ##
  ## Returns a copy of the hash as an OpenStruct.
  #def to_ostruct()
  #  struct = OpenStruct.new(self.clone())
  #  each do |k, v|
  #    struct.__send__("#{k}=", v.to_ostruct()) if v.is_a?(Hash)
  #    struct.__send__(k).map! {|x| x.is_a?(Hash) ? x.to_ostruct() : x} if v.is_a?(Array)
  #  end
  #  return struct
  #end

  # Like `#to_ostruct` but recusively objectifies all hash elements as well.
  #
  #     o = {'a' => { 'b' => 1 }}.to_ostruct_recurse
  #     o.a.b  #=> 1
  #
  # The `exclude` parameter is used internally to prevent infinite
  # recursion and is not intended to be utilized by the end-user.
  # But for more advance use, if there is a particular subhash you
  # would like to prevent from being converted to an OpoenStruct
  # then include it in the `exclude` hash referencing itself. e.g.
  #
  #     h = { 'a' => { 'b' => 1 } }
  #     o = h.to_ostruct_recurse( { h['a'] => h['a'] } )
  #     o.a['b']  #=> 1
  #
  # CREDIT: Alison Rowland, Jamie Macey, Mat Schaffer
  def to_ostruct_recurse(exclude={})
    return exclude[self] if exclude.key?( self )
    o = exclude[self] = OpenStruct.new
    h = self.dup
    each_pair do |k,v|
      h[k] = v.to_ostruct_recurse( exclude ) if v.respond_to?(:to_ostruct_recurse)
    end
    o.merge!(h)
  end
end

class NilClass
  # Create an empty OpenStruct object.
  def to_ostruct
    OpenStruct.new
  end
end

