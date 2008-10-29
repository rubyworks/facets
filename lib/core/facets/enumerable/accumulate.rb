require 'facets/functor'

module Enumerable

  # Accumulate a set of a set.
  #
  # For example, in an ORM design if Group
  # has_many User then
  #
  #   groups.accumulate.users
  #
  # will return a list of users from all groups.

  def accumulate
    @_accumulate ||= Functor.new do |op, *args|
      inject([]) { |a, x| a << x.send(op, *args) }.flatten
    end
  end

end

