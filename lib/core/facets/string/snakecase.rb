class String

  # The reverse of +camelcase+. Makes an underscored of a camelcase string.
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # Examples
  #   "SnakeCase".snakecase           #=> "snake_case"
  #   "Snake-Case".snakecase          #=> "snake_case"
  #   "SnakeCase::Errors".underscore  #=> "snake_case/errors"

  def snakecase
    gsub(/::/, '/').  # NOT SO SURE ABOUT THIS -T
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

end

