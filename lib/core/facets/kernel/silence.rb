module Kernel

  # Silences any stream for the duration of the block.
  #
  #   silence_stream(STDOUT) do
  #     puts 'This will never be seen'
  #   end
  #
  #   puts 'But this will'
  #
  #   CREDIT: David Heinemeier Hansson

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

  #
  def silence_stderr #:yeild:
    silence_stream(STDERR) { yield }
  end

  #
  def silence_stdout #:yeild:
    silence_stream(STDOUT) { yield }
  end

  # Just like silence_stream, but will default to 
  # STDOUT, STDERR if no streams are given.

  def silently(*streams) #:yeild:
    streams = [STDOUT, STDERR] if streams.empty?
    silence_stream(*streams){ yield }
  end

  # Sets $VERBOSE to nil for the duration of the block
  # and back to its original value afterwards.
  #
  #   silence_warnings do
  #     value = noisy_call # no warning voiced
  #   end
  #
  #   noisy_call  # no warning is voiced
  #
  #  CREDIT: David Heinemeier Hansson

  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end

  # Sets $VERBOSE to true for the duration of the block
  # and back to its original value afterwards.
  #
  #  CREDIT: David Heinemeier Hansson

  def enable_warnings
    old_verbose, $VERBOSE = $VERBOSE, true
    yield
  ensure
    $VERBOSE = old_verbose
  end

end

