class Hash

  # Turn a hash into a method arguments.
  #
  #   h = { :list => [1,2], :base => "HI" }
  #
  # Without an argument field.
  #
  #   h.argumentize #=> [ { :list => [1,2], :base => "HI" } ]
  #
  # With an argument field.
  #
  #   h.argumentize(:list)   #=> [ 1, 2, { :base => "HI" } ]
  #   h.argumentize(:base)   #=> [ "HI", { :list => [1,2] } ]
  #
  def argumentize(args_field=nil)
    config = dup
    if args_field
      args = [config.delete(args_field)].flatten.compact
    else
      args = []
    end
    args << config
    return args
  end

end

