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
  def silence(*streams) #:yield:
    streams = streams.map do |stream|
      case stream
      when :stderr
        STDERR
      when :stdout
        STDOUT
      else
        stream
      end
    end

    if streams.empty?
      yield
    else
      silence_stream(*streams){ yield }
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

end

