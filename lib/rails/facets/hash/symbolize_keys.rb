class Hash

  # NOTE: These are provided because of their prevalence with Rails users.
  # We strongly encourage using #rekey instead.


  # Return a new hash with all keys converted to symbols. With a +select+ block,
  # limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', 'wife'=>:Lisa }
  #   foo.symbolize_keys    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #   foo                   #=>  { :name =>"Gavin", "wife"=>:Lisa }
  #
  # If the key does not respond to #to_sym, then #to_s will be used first.
  #
  # For a more versatile method, see #rekey instead.

  def symbolize_keys(&select)
    dup.symbolize_keys!(&select)
  end

  # Destructively convert all keys to symbols. This is the same as
  # Hash#symbolize_keys, but modifies the receiver in place and returns it.
  # With a +select+ block, limits conversion to only selected keys.
  #
  #   foo = { 'name'=>'Gavin', 'wife'=>:Lisa }
  #   foo.symbolize_keys!    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #   foo                    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #
  # If the key does not respond to #to_sym, then #to_s will be used first.
  #
  # For a more versatile method, see #rekey instead.

  def symbolize_keys!(&select)
    if select
      keys.each do |key|
        if select[key]
          new_key = (key.to_sym rescue key.to_s.to_sym)
          self[new_key] = delete(key)
        end
      end       
    else
      keys.each do |key|
        new_key = (key.to_sym rescue key.to_s.to_sym)
        self[new_key] = delete(key)
      end
    end
    self
  end

  # Return a new hash with all keys converted to strings. Converts all keys
  # in the Hash to Strings, returning a new Hash. With a +select+ block,
  # limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                   #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  # This method is considered archaic. Use #rekey instead.

  def stringify_keys(&select)
    dup.stringify_keys!(&select)
  end

  # Destructively convert all keys to strings. This is the same as
  # Hash#stringify_keys, but modifies the receiver in place and
  # returns it. With a +select+ block, limits conversion to only
  # certain keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys!    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  # This method is considered archaic. Use #rekey instead.

  def stringify_keys!(&select)
    if select
      keys.each do |key|
        if select[key]
          self[key.to_s] = delete(key)
        end
      end
    else
      keys.each do |key|
        self[key.to_s] = delete(key)
      end
    end
    self
  end

end

