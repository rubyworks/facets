covers 'facets/kernel/disable_warnings'
covers 'facets/kernel/enable_warnings'
covers 'facets/kernel/silence_warnings'

tests Kernel do

  unit :disable_warnings do
    disable_warnings do
      assert( ! $VERBOSE )
    end
  end

  unit :silence_warnings => "alias for backward compatibility" do
    silence_warnings do
      assert( ! $VERBOSE )
    end
  end

  unit :enable_warnings do
    enable_warnings do
      assert( $VERBOSE )
    end
  end

end

