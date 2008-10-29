class Module

  # Is a given class or module an ancestor of
  # this class or module?
  #
  #  class X ; end
  #  class Y < X ; end
  #
  #   X.ancestor?(Y)

  def ancestor?( mod )
    ancestors.include? mod
  end

end

