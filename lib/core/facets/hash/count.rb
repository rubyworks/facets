class Hash

  # Ruby's own Hash#count, from Enumerable, counts key-value pairs:
  #
  #   {:A=>1, :B=>1}.count([:A, 1])  #=> 1
  #
  # Facets' version used to count values instead, which changed Ruby's
  # answer for every library in the program. It now returns Ruby's answer,
  # and warns when given something that can't be a key-value pair, since
  # that's how the old Facets version was called. To count values, use
  # `hash.values.count(value)`.
  #
  #   {:A=>1, :B=>1}.values.count(1)  #=> 2
  #
  # @deprecated Facets no longer changes Hash#count. This warning wrapper is
  #   scheduled for removal after 2027-09-30.
  #
  def count(*args, &block)
    if args.size == 1 && !(Array === args.first && args.first.size == 2)
      warn "Facets' Hash#count(value) is deprecated. Hash#count now counts key-value pairs, " \
           "as Ruby's own does, so this returns 0. To count values, use hash.values.count(value). " \
           "It will be removed after 2027-09-30.", uplevel: 1
    end
    super
  end

end
