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
  # 
  # you may pass an argument to perform chains, e.g.
  #  groups.accumulate(2).users.name #=> names of users from all groups
  #  OR groups.accumulate(2).users.friends #=> all the friends of all users in groups
  #
  # CREDIT: George Moshchovitis

  def accumulate(iterations = 1)
    return self if iterations == 0
    @_accumulate ||= Functor.new do |op, *args|
      result = inject([]) { |a, x| a << x.send(op, *args) }.flatten
      result.accumulate(iterations - 1)
    end
  end

end

