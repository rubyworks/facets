require 'facets/hash/rekey'

class Hash

  # Converts all keys in the Hash to Symbols, returning a new Hash.
  # With a +filter+, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', 'wife'=>:Lisa }
  #   foo.symbolize_keys    #=>  { :name=>"Gavin", :wife=>:Lisa }
  #   foo.inspect           #=>  { "name" =>"Gavin", "wife"=>:Lisa }
  #
  # This method is considered archaic. Use #rekey instead.

  def symbolize_keys(&filter)
    if filter
      rekey{ |k| filter[k] ? k.to_sym : nil }
    else
      rekey{ |k| k.to_sym }
    end
  end

  #alias_method( :keys_to_sym, :symbolize_keys )

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
  # This method is considered archaic. Use #rekey instead.

  def symbolize_keys!(&filter)
    if filter
      rekey!{ |k| filter[k] ? k.to_sym : nil }
    else
      rekey!{ |k| k.to_sym }
    end

  end

  #alias_method( :keys_to_sym!, :symbolize_keys! )

  # Converts all keys in the Hash to Strings, returning a new Hash.
  # With a +filter+ parameter, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect           #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  # This method is considered archaic. Use #rekey instead.

  def stringify_keys(&filter)
    if filter
      rekey{ |k| filter[k] ? k.to_s : nil }
    else
      rekey{ |k| k.to_s }
    end
  end

  #alias_method(:keys_to_s, :stringify_keys)

  # Synonym for Hash#stringify_keys, but modifies the receiver in place and returns it.
  # With a +filter+ parameter, limits conversion to only a certain selection of keys.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.stringify_keys!    #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo.inspect            #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  # This method is considered archaic. Use #rekey instead.

  def stringify_keys!(&filter)
    if filter
      rekey!{ |k| filter[k] ? k.to_s : nil }
    else
      rekey!{ |k| k.to_s }
    end
  end

  #alias_method( :keys_to_s!, :stringify_keys!)

  #--
  # # Rails has these aliases too.
  # alias_method( :to_options!, :symbolize_keys! )
  #++

end

