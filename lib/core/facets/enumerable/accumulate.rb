require 'facets/functor'

module Enumerable

  # Accumulate a set of a set. For example, in an ORM design
  # where <code>Group has_many User</code> then
  #
  #   groups.accumulate.users
  #
  # will return a list of users from all groups.
  # You may pass an argument to perform chains, e.g. 
  #
  #   groups.accumulate(2).users.name
  #
  # returns the names of users from all groups, or
  #
  #   groups.accumulate(2).users.friends
  #
  # returns all the friends of all users in groups.
  # This is more convenient then the equivalent.
  #
  #   groups.accumulate.users.accumulate.friends
  #
  # CREDIT: George Moshchovitis, Daniel Emirikol

  def accumulate(iterations = 1)
    return self if iterations == 0
    Functor.new do |op, *args|
      result = inject([]) { |a, x| a << x.send(op, *args) }.flatten
      result.accumulate(iterations - 1)
    end
  end

end

