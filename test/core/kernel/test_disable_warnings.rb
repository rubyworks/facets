covers 'facets/kernel/disable_warnings'
covers 'facets/kernel/enable_warnings'
covers 'facets/kernel/silence_warnings'

test_case Kernel do

  method :disable_warnings do

    test do
      disable_warnings do
        assert( ! $VERBOSE )
      end
    end

  end

  method :silence_warnings do

    test "alias for backward compatibility" do
      silence_warnings do
        assert( ! $VERBOSE )
      end
    end

  end

  method :enable_warnings do

    test :enable_warnings do
      enable_warnings do
        assert( $VERBOSE )
      end
    end

  end

end

