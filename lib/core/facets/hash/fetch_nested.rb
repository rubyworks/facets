class Hash

  # nil safe version of Hash#[].
  #
  #   {'hello'=>{'world'=>42}}.fetch_nested(*['hello','world']) #=> 42
  #   {}.fetch_nested(*['hello','world']) #=> nil
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
