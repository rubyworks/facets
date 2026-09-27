module Kernel

  # Silence a stream and/or warnings...
  #
  #   silence(:stdout) do
  #     puts "won't see me"
  #   end
  #
  # Supported +streams+ are +stderr+, +stdout+, +verbose+, +debug+,
  # and +warnings+, which is the same as +verbose+. You can also
  # use the actual streams, STDERR and STDOUT.
  #
  #   silence(:verbose) do
  #     warn "won't see me either"
  #   end
  #
  # +verbose+ sets $VERBOSE to nil and +debug+ sets $DEBUG to false
  # for the duration of the block.
  #
  # Silencing a stream works by reopening it on the null device, so it
  # affects the whole process, not just the current thread.
  def silence(*streams) #:yield:
    verbose, debug = $VERBOSE, $DEBUG
    $VERBOSE = nil   if (streams & [:verbose, :warnings]).any?
    $DEBUG   = false if streams.include?(:debug)

    streams = (streams - [:verbose, :warnings, :debug]).map do |stream|
      {stderr: STDERR, stdout: STDOUT}.fetch(stream, stream)
    end

    on_hold = streams.collect{ |stream| stream.dup }
    streams.each do |stream|
      stream.reopen(File::NULL)
      stream.sync = true
    end
    yield
  ensure
    streams.each_with_index do |stream, i|
      stream.reopen(on_hold[i])
    end if on_hold
    $VERBOSE, $DEBUG = verbose, debug
  end

  # Just like #silence, but will default to
  # STDOUT, STDERR if no streams are given.

  def silently(*streams) #:yeild:
    streams = [STDOUT, STDERR] if streams.empty?
    silence(*streams){ yield }
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
  #
  # @deprecated Use #silence instead, which takes the same arguments.
  #   Scheduled for removal after 2027-09-30.

  def silence_stream(*streams) #:yeild:
    warn "Kernel#silence_stream is deprecated. Use Kernel#silence instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    silence(*streams){ yield }
  end

  # Equivalent to `silence(STDERR)`.
  def silence_stderr #:yeild:
    silence(STDERR) { yield }
  end

  # Equivalent to `silence(STDOUT)`.
  def silence_stdout #:yeild:
    silence(STDOUT) { yield }
  end

end
