require 'facets/hash/recurse'
require 'facets/hash/rekey'

class Hash

  # Rekey a hash and all sub-hashes:
  #
  #   deep_rekey()
  #   deep_rekey(from_key => to_key, ...)
  #   deep_rekey{|from_key| to_key}
  #   deep_rekey{|from_key, value| to_key}
  #
  # If a key map is given, then the first key is changed to the second key.
  #
  #   foo = { :c=>{ :a=>1, :b=>2 } }
  #   foo.deep_rekey(:a=>'a')       #=> { :c=>{ 'a'=>1, :b=>2 } }
  #   foo.deep_rekey(:b=>:x)        #=> { :c=>{ :a =>1, :x=>2 } }
  #   foo.deep_rekey('foo'=>'bar')  #=> { :c=>{ :a =>1, :b=>2 } }
  #
  # If a block is given, converts all keys in the Hash accroding to the
  # given block procedure.
  #
  #   foo = { :person=>{ :name=>'Gavin', :wife=>:Lisa } }
  #   foo.deep_rekey{ |k| k.to_s }  #=>  { "person"=>{ "name"=>"Gavin", "wife"=>:Lisa } }
  #   foo                      #=>  { "person"=>{ "name"=>"Gavin", "wife"=>:Lisa } }
  #
  # If no key map or block is given, then all keys are converted
  # to Symbols.
  #
  # Raises an ArgumentError if both a +key_map+ and a block are given.
  # If both are needed just call #deep_rekey twice.
  #
  # TODO: If `nil` is returned by block should the key be set to `nil` or the orignal key?
  #
  # CREDIT: Trans, Gavin Kistner, Ryan Duryea

  def deep_rekey(key_map=nil, &block)
    recurse do |h|
      h.rekey(key_map, &block)
    end
  end

  # Synonym for Hash#deep_rekey, but modifies the receiver in place (and returns it).
  #
  #   foo = { :person=>{ :name=>'Gavin', :wife=>:Lisa } }
  #   foo.deep_rekey!{ |k| k.to_s }  #=>  { "person"=>{ "name"=>"Gavin", "wife"=>:Lisa } }
  #   foo                       #=>  { "person"=>{ "name"=>"Gavin", "wife"=>:Lisa } }
  #
  # CREDIT: Trans, Gavin Kistner, Ryan Duryea

  def deep_rekey!(key_map=nil, &block)
    replace(deep_rekey(key_map, &block))
  end
end
