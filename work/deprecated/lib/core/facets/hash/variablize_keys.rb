# DEPRECATED b/c of Hash#rekey and String#variablize (variablize is defined in metaid.rb).

class Hash

  # Converts all keys in the Hash to be String values, returning a new Hash.
  # With a from_class parameter, limits conversion to only a certain class of keys.
  # It defaults to nil which convert any key class.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.variablize_keys    #=>  { "@name"=>"Gavin", "@wife"=>:Lisa }
  #   foo.inspect            #=>  { :name =>"Gavin", :wife=>:Lisa }

  def variablize_keys( of_class=nil )
    self.dup.variablize_keys!( of_class )
  end

  # Synonym for Hash#keys_to_string, but modifies the receiver in place (and returns it).
  # With a from_class parameter, limits conversion to only a certain class of keys.
  # It defaults to nil which convert any key class.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.variablize_keys!   #=>  { "@name"=>"Gavin", "@wife"=>:Lisa }
  #   foo.inspect            #=>  { "@name"=>"Gavin", "@wife"=>:Lisa }

  def variablize_keys!(of_class=nil)
    raise ArgumentError, "Parameter must be a class" unless of_class.kind_of?(Class) if of_class
    if of_class
      self.each_key do |k|
        if k.respond_to?(:to_s) and k.class == of_class
          k = k.to_s
          nk = k[0,1] != '@' ? k : "@#{k}"
          self[nk]=self.delete(k)
        end
      end
    else
      self.each_key do |k|
        if k.respond_to?(:to_s)
          k = k.to_s
          nk = k[0,1] != '@' ? k : "@#{k}"
          self[nk]=self.delete(k)
        end
      end
    end
    self
  end

end

