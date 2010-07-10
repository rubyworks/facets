require 'facets/symbol/to_proc'

class Hash

  # Rekey a hash, ...
  #
  #   rekey()
  #   rekey(to_key, from_key)
  #   rekey{|from_key| to_key}
  #
  # If no arguments or block are given, then all keys are converted
  # to Symbols.
  #
  # If two keys are given, then the second key is changed to
  # the first. You can think of it as +alias+ for hash keys.
  #
  #   foo = { :a=>1, :b=>2 }
  #   foo.rekey('a',:a)       #=> { 'a'=>1, :b=>2 }
  #   foo.rekey(:x,:b)        #=> { :a =>1, :x=>2 }
  #   foo.rekey('foo','bar')  #=> { :a =>1, :b=>2 }
  #
  # If a block is given, converts all keys in the Hash accroding
  # to the given block. If the block returns +nil+ for given key,
  # then that key will be left intact.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                      #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  # CREDIT: Trans, Gavin Kistner

  def rekey(*args, &block)
    dup.rekey!(*args, &block)
  end

  # Synonym for Hash#rekey, but modifies the receiver in place (and returns it).
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey!{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                       #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  # CREDIT: Trans, Gavin Kistner

  def rekey!(*args, &block)
    # for backward comptability (TODO: DEPRECATE).
    block = args.pop.to_sym.to_proc if args.size == 1
    # if no args use block.
    if args.empty?
      block = lambda{|k| k.to_sym} unless block
      keys.each do |k|
        nk = block[k]
        self[nk]=delete(k) if nk
      end
    else
      raise ArgumentError, "3 for 2" if block
      to, from = *args
      self[to] = self.delete(from) if self.has_key?(from)
    end
    self
  end

end

