class Hash

  # NOTE: This method is really usurped by Hash#rekey.
  #       It remains available for the time being for improved
  #       intercompability with Rail's ActiveSupport library.

  # Converts all keys in the Hash accroding to the given block.
  # If the block return +nil+ for given key, then that key will be
  # left intact.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.normalize_keys{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect                       #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  #  CREDIT: Trans
  #  CREDIT: Gavin Sinclair

  def normalize_keys( &block )
    dup.send(:normalize_keys!, &block)
  end

  # Synonym for Hash#normalize_keys, but modifies the receiver in place (and returns it).
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.normalize_keys!{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect                        #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  #   CREDIT: Trans
  #   CREDIT: Gavin Sinclair

  def normalize_keys!( &block )
    keys.each{ |k|
      nk = block[k]
      self[nk]=delete(k) if nk
    }
    self
  end

  # Converts all keys in the Hash to Symbols, returning a new Hash.
  # With a +filter+, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', 'wife'=>:Lisa }
  #   foo.symbolize_keys    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #   foo.inspect           #=>  { "name" =>"Gavin", "wife"=>:Lisa }
  #
  #   CREDIT: Trans
  #   CREDIT: Gavin Sinclair

  def symbolize_keys( &filter )
    if filter
      normalize_keys{ |k| filter[k] ? k.to_sym : nil }
    else
      normalize_keys{ |k| k.to_sym }
    end
  end

  alias_method( :keys_to_sym, :symbolize_keys )

  #--
  # # Rails has these aliases too, but they are not very good for
  # # gerenal use, IMHO. But perhaps someone can convince me otherwise.
  # alias_method( :to_options,  :symbolize_keys )
  #++

  # Synonym for Hash#symbolize_keys, but modifies the receiver in place and returns it.
  # With a +filter+ parameter, limits conversion to only a certain selection of keys.
  #
  #   foo = { 'name'=>'Gavin', 'wife'=>:Lisa }
  #   foo.symbolize_keys!    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #   foo.inspect            #=>  { :name=>"Gavin", :wife=>:Lisa }
  #
  #   CREDIT: Trans
  #   CREDIT: Gavin Sinclair

  def symbolize_keys!( &filter )
    if filter
      normalize_keys!{ |k| filter[k] ? k.to_sym : nil }
    else
      normalize_keys!{ |k| k.to_sym }
    end

  end

  alias_method( :keys_to_sym!, :symbolize_keys! )

  #--
  # # Rails has these aliases too, but they are not very good for
  # # gerenal use, IMHO. But perhaps someone can convince me otherwise.
  # alias_method( :to_options!, :symbolize_keys! )
  #++


  # Converts all keys in the Hash to Strings, returning a new Hash.
  # With a +filter+ parameter, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect           #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  #   CREDIT: Trans
  #   CREDIT: Gavin Sinclair

  def stringify_keys( &filter )
    if filter
      normalize_keys{ |k| filter[k] ? k.to_s : nil }
    else
      normalize_keys{ |k| k.to_s }
    end
  end

  alias_method(:keys_to_s, :stringify_keys)

  # Synonym for Hash#stringify_keys, but modifies the receiver in place and returns it.
  # With a +filter+ parameter, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys!    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect            #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  #   CREDIT: Trans
  #   CREDIT: Gavin Sinclair

  def stringify_keys!( &filter )
    if filter
      normalize_keys!{ |k| filter[k] ? k.to_s : nil }
    else
      normalize_keys!{ |k| k.to_s }
    end
  end

  alias_method( :keys_to_s!, :stringify_keys!)

end

