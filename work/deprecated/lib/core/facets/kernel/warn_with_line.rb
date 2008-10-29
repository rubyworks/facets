module Kernel

  # DEPRECATE:
  #   Just use:
  #     puts __LINE__ + ": your message"
  #     p caller
  
  # Outputs the current caller trace.
  #
  #   warn_with_line("You have been warned.")
  #
  # _produces_
  #
  #   3: "You have been warned."
  #
  # Note that this method depends on the output of #caller.
  #
  # TODO: This may be useful but the naem is wrong. It's a debug output
  #       not a "warning" output.

  def warn_with_line(msg="", fulltrace=true)
    trac = caller(1)
    where = trac[0].sub(/:in.*/,'')
    STDERR.puts "#{where}: #{msg.inspect}"
    STDERR.puts trac.map { |t| "\tfrom #{t}" } if fulltrace
  end

end

