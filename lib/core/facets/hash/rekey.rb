require 'facets/symbol/to_proc'

class Hash

  # Rekey a hash, ...
  #
  #   rekey()
  #   rekey(from_key => to_key, ...)
  #   rekey{|from_key| to_key}
  #
  # If no key map or block is given, then all keys are converted
  # to Symbols.
  #
  # If a key map is given, then the first key is changed to the second key.
  #
  #   foo = { :a=>1, :b=>2 }
  #   foo.rekey(:a=>'a')       #=> { 'a'=>1, :b=>2 }
  #   foo.rekey(:b=>:x)        #=> { :a =>1, :x=>2 }
  #   foo.rekey('foo'=>'bar')  #=> { :a =>1, :b=>2 }
  #
  # If a block is given, converts all keys in the Hash accroding to the
  # given block procedure. If the block returns +nil+ for given key,
  # then that key will be left intact.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                      #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  # Note that if both a +key_map+ and a block are given, the +key_map+ is 
  # applied first then the block.
  #
  # CREDIT: Trans, Gavin Kistner

  def rekey(key_map={}, &block)
    if key_map.empty? && !block
      block = lambda{|k| k.to_sym}
    end

    hash = {}

    (keys - key_map.keys).each do |key|
      hash[key] = self[key]
    end

    key_map.each do |from, to|
      hash[to] = self[from]
    end

    hash2 = {}

    if block
      hash.each do |k, v|
        nk = block[k]
        hash2[nk || k] = v
      end
    else
      hash2 = hash
    end

    hash2
  end

  # Synonym for Hash#rekey, but modifies the receiver in place (and returns it).
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey!{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                       #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  # CREDIT: Trans, Gavin Kistner

  def rekey!(key_map={}, &block)
    replace(rekey(key_map, &block))
  end

end
