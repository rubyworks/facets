class Hash

  # Same as Hash#merge but recursively merges sub-hashes.
  #
  #   {a: {b: 1, c: 2}}.deep_merge(a: {b: 3})  #=> {a: {b: 3, c: 2}}
  #
  # Like Hash#merge, it takes a block to decide the value of a key both
  # hashes have, other than one that is itself merged.
  #
  #   {a: {b: 1}}.deep_merge(a: {b: 2}) { |key, mine, theirs| mine + theirs }
  #   #=> {a: {b: 3}}
  #
  # A sub-hash is merged only when the other value is a hash too. This
  # matches ActiveSupport's Hash#deep_merge, so the two agree whichever is
  # loaded, and it honors ActiveSupport's #deep_merge? when that's defined.

  def deep_merge(other, &block)
    dup.deep_merge!(other, &block)
  end

  # Same as Hash#merge! but recursively merges sub-hashes. The sub-hashes
  # themselves aren't changed; merged copies replace them.

  def deep_merge!(other, &block)
    merge!(other) do |key, mine, theirs|
      deep = Hash === mine &&
        (mine.respond_to?(:deep_merge?) ? mine.deep_merge?(theirs) : Hash === theirs)
      if deep
        mine.deep_merge(theirs, &block)
      elsif block
        block.call(key, mine, theirs)
      else
        theirs
      end
    end
  end

end
