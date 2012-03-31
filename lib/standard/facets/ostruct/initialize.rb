require 'ostruct'

class OpenStruct

  # Allows the initialization of an OpenStruct with a setter block:
  #
  #   person = OpenStruct.new do |o|
  #     o.name    = 'John Smith'
  #     o.gender  = :M
  #     o.age     = 71
  #   end
  #
  # You can still provide a hash for initialization purposes, and even combine
  # the two approaches if you wish.
  #
  #   person = OpenStruct.new(:name => 'John Smith', :age => 31) do |p|
  #     p.gender = :M
  #   end
  #
  # Alternatively you can provide a default block:
  #
  #   stuff = OpenStruct.new{ |o,k| o[k] = [] }
  #   stuff.place << :a
  #   stuff.place << :b
  #   stuff.place #=> [:a, :b]
  #
  # A setter block versus a defualt block is determined by the arity of
  # the block. You cannot provide both at the same time.
  #
  # CREDIT: Noah Gibbs, Gavin Sinclair
  def initialize(hash=nil, &block)
    if block && block.arity==2
      @table = Hash.new(&block)
    else
      @table = {}
    end
    if hash
      for k,v in hash
        @table[k.to_sym] = v
        new_ostruct_member(k)
      end
    end
    if block && block.arity==1
      yield self
    end
  end

end
