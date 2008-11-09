require 'facets/hash/rekey'

class Hash

  # NOTE: These are in disfavor, but are provided
  # because of their prevalence with Rails users.
  # We strongly encourage using #rekey instead.

  unless defined?(::ActiveSupport)

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

    alias_method( :to_options, :symbolize_keys )
    alias_method( :to_options!, :symbolize_keys! )

    # These were the original names used by Facets but
    # have been deprecated in favor of the Railisms.
    #alias_method( :keys_to_sym, :symbolize_keys )
    #alias_method( :keys_to_s, :stringify_keys)
    #alias_method( :keys_to_sym!, :symbolize_keys! )
    #alias_method( :keys_to_s!, :stringify_keys!)

  end

end

