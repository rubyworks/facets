module Kernel

  # For debugging and showing examples. Currently this
  # takes an argument of a string in a block.
  #
  #   demo {%{ a = [1,2,3] }}
  #   demo {%{ a.slice(1,2) }}
  #   demo {%{ a.map { |x| x**3 } }}
  #
  # Produces:
  #
  #   a = [1,2,3]             #=>  [1, 2, 3]
  #   a.slice(1,2)            #=>  [2, 3]
  #   a.map { |x| x**3 }      #=>  [1, 8, 27]
  #
  #   TODO: Is there a way to do this without the eval string in block?
  #         Preferably just a block and no string.

  def demo(out=$stdout,&block)
    out << sprintf("%-25s#=>  %s\n", expr = block.call, eval(expr, block.binding).inspect)
  end

end
