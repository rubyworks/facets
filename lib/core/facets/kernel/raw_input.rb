module Kernel
  
  # Displays a prompt and returns chomped input.
  # Modelled after the Python method of the same
  # name.
  #
  # CREDIT: Michael Kohl

  def raw_input(prompt='')
    print prompt unless prompt.empty?
    gets.chomp!
  end
  
end
