require 'facets/functor'

module Enumerable

  # Accumulate a set of a set. For example, in an ORM design
  # where `Group has_many User` we might have something
  # equivalent to the following.
  #
  #   Group = Struct.new(:users)
  #   User  = Struct.new(:name, :friends)
  #
  #   user1 = User.new('John', [])
  #   user2 = User.new('Jane', ['Jill'])
  #   user3 = User.new('Joe' , ['Jack', 'Jim'])
  #
  #   group1 = Group.new([user1, user2])
  #   group2 = Group.new([user2, user3])
  #
  #   groups = [group1, group2]
  #
  # Now we can *accumulate* the users of all groups.
  #
  #   groups.accumulate.users  #=> [user1, user2, user3]
  #
  # You may pass an argument to perform chains, e.g. the following
  # returns the names of users from all groups.
  #
  #   groups.accumulate(2).users.name  #=> ['John','Jane','Joe']
  #
  # Or we can gather all the friends of all users in groups.
  #
  #   groups.accumulate(2).users.friends  #=> ['Jill','Jack','Jim']
  # 
  # This is more convenient then the equivalent.
  #
  #   groups.accumulate.users.accumulate.friends  #=> ['Jill','Jack','Jim']
  #
  # CREDIT: George Moshchovitis, Daniel Emirikol

  def accumulate(iterations = 1)
    return self if iterations == 0
    Functor.new do |op, *args|
      result = inject([]) { |a, x| a << x.send(op, *args) }.flatten.uniq
      result.accumulate(iterations - 1)
    end
  end

end

