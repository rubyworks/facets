class NilClass
  # Simply returns nil.
  #
  # Useful for something like:
  #
  #   if some_hash[:a][:b]
  #   # (where some_hash is a hash of hashes)
  #
  # which would throw a NoMethodError if some_hash didn't have a value for :a.
  #
  # I haven't had any problems using this yet, but it has the possibility of
  # causing some problems with libraries that depend on the other behavior.
  def [](key)
    nil
  end
end

# Try the following with and without NilClass#[] defined to see the difference.
some_hash = {}

if some_hash[:a][:b]
  puts("got in")
else
  puts("didn't get in")
end