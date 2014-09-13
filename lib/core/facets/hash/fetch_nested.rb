class Hash

  # Similar to Hash#fetch but supports nested lookup and is `nil` safe.
  #
  #     {}.fetch_nested('anything','at','all')  #=> nil
  #
  #     h = {'hello'=>{'world'=>42}}
  #     h.fetch_nested(*['hello','world'])  #=> 42
  #
  # CREDIT: T. Yamada and Sean Mackesey

  def fetch_nested(*keys)
    begin
      keys.reduce(self){|accum, k| accum.fetch(k)}
	rescue (RUBY_VERSION<'1.9' ? IndexError : KeyError)
      block_given? ? yield(*keys) : nil
    end
  end

end
