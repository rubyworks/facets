module Kernel

  # Silence a stream and/or warnings...
  #
  #   silence(:stdout, :verbose) do
  #     puts "won't see me"
  #     warn "won't see me either"
  #   end
  #
  # Supported +streams+ are +stderr+, +stdout+, +verbose+, +debug+,
  # and +warnings+, which is the same as +verbose+. You can also
  # use the actual streams, STDERR and STDOUT.
  def silence(*streams) #:yield:
    streams = streams.map do |stream|
      case stream
      when :stderr
        STDERR
      when :stdout
        STDOUT
      when :debug, :debugging
        :debug
      when :verbose, :warnings, :warning
        :verbose
      else
        stream
      end
    end

    debug   = $DEBUG
    verbose = $VERBOSE

    $DEBUG   = false if streams.delete(:debug)
    $VERBOSE = false if streams.delete(:verbose)

    begin
      if streams.empty?
        yield
      else
        silence_stream(*streams){ yield }
      end
    ensure
      $DEBUG   = debug
      $VERBOSE = verbose
    end
  end

  # Just like silence_stream, but will default to
  # STDOUT, STDERR if no streams are given.

  def silently(*streams) #:yeild:
    streams = [STDOUT, STDERR] if streams.empty?
    silence_stream(*streams){ yield }
  end

  # Silences any stream for the duration of the block...
  #
  #   silence_stream(STDOUT) do
  #     puts 'This will never be seen'
  #   end
  #
  #   puts 'But this will'
  #
  # CREDIT: David Heinemeier Hansson

  def silence_stream(*streams) #:yeild:
    on_hold = streams.collect{ |stream| stream.dup }
    streams.each do |stream|
      stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
      stream.sync = true
    end
    yield
  ensure
    streams.each_with_index do |stream, i|
      stream.reopen(on_hold[i])
    end
  end

  # Equivalent to `silence_stream(STDERR)`.
  def silence_stderr #:yeild:
    silence_stream(STDERR) { yield }
  end

  # Equivalent to `silence_stream(STDOUT)`.
  def silence_stdout #:yeild:
    silence_stream(STDOUT) { yield }
  end

  # Sets $VERBOSE to nil for the duration of the block
  # and back to its original value afterwards...
  #
  #   silence_warnings do
  #     value = noisy_call # no warning voiced
  #   end
  #
  #   noisy_call  # no warning is voiced
  #
  # CREDIT: David Heinemeier Hansson

  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end

  # Sets $VERBOSE to true for the duration of the block
  # and back to its original value afterwards.
  #
  # CREDIT: David Heinemeier Hansson

  def enable_warnings
    old_verbose, $VERBOSE = $VERBOSE, true
    yield
  ensure
    $VERBOSE = old_verbose
  end

end

