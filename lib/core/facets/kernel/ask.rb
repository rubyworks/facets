module Kernel

  module_function

  # Very simple convenience method to get a console reply.
  #
  #   ask "Are you happy?", "Yn"
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

  def ask(question, answers=nil)
    $stdout << "#{question}"
    $stdout << " [#{answers}] " if answers
    until inp = $stdin.gets ; sleep 1 ; end
    inp.strip
  end

end

