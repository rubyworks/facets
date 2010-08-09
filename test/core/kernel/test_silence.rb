Covers 'facets/kernel/silence'

Case Kernel do

  Unit :silence_warnings do
    silence_warnings do
      assert( ! $VERBOSE )
    end
  end

end
