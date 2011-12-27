class String

  # Underscore a string such that camelcase, dashes and spaces are
  # replaced by underscores. This is the reverse of {#camelcase},
  # albeit not an exact inverse.
  #
  #   "SnakeCase".snakecase         #=> "snake_case"
  #   "Snake-Case".snakecase        #=> "snake_case"
  #   "Snake Case".snakecase        #=> "snake_case"
  #   "Snake  -  Case".snakecase    #=> "snake_case"
  #
  # Note, this method no longer converts `::` to `/`, in that case
  # use the {#pathize} method instead.

  def snakecase
    #gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr('-', '_').
    gsub(/\s/, '_').
    gsub(/__+/, '_').
    downcase
  end

  #
  alias_method :underscore, :snakecase

  # TODO: Add *separators to #snakecase, like camelcase.

end

