module Kernel

  module_function

  # Very simple convenience method to get user input
  # via the console. A prompt will be sent to $stdout,
  # if given, and the input taken from $stdin.
  #
  #   ask "Are you happy? [Yn]"
  #
  # On the command line one would see.
  #
  #   $ Are you happy? [Yn]
  #
  # Responding:
  #
  #   $ Are you happy? [Yn] Y <ENTER>
  #
  # The ask method would return "Y".

  def ask(prompt=nil)
    $stdout << "#{prompt}"
    $stdout.flush
    $stdin.gets.chomp!
  end

end

