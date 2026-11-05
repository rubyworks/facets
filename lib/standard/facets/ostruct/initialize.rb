require 'ostruct'

class OpenStruct

  alias_method :__initialize_without_block__, :initialize
  private :__initialize_without_block__

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
  # The hash is handled by Ruby's own OpenStruct#initialize, which this
  # calls first.
  #
  # CREDIT: Noah Gibbs, Gavin Sinclair
  def initialize(hash=nil, &block)
    __initialize_without_block__(hash)
    if block && block.arity == 1
      yield self
    end
  end

end
