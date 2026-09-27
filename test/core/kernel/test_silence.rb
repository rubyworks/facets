covers 'facets/kernel/silence'

test_case Kernel do

  # TODO: figure out how to test silence methods

  concern "Not straight foward to test since they effect output."

  method :silence do

    test "verbose and warnings unset $VERBOSE within the block" do
      silence(:verbose){ $VERBOSE }.assert == nil
      silence(:warnings){ $VERBOSE }.assert == nil
    end

    test "debug unsets $DEBUG within the block" do
      debug = $DEBUG
      begin
        $DEBUG = true
        silence(:debug){ $DEBUG }.assert == false
        $DEBUG.assert == true
      ensure
        $DEBUG = debug
      end
    end

    test "restores $VERBOSE even if the block raises" do
      verbose = $VERBOSE
      begin
        silence(:verbose){ raise "boom" }
      rescue RuntimeError
      end
      $VERBOSE.assert == verbose
    end

    test "returns the block's value" do
      silence{ 42 }.assert == 42
    end

  end

  method :silence_stream do
  end

  method :silence_stderr do
  end

  method :silence_stdout do
  end

  method :silently do
  end

end
