class String

  # The reverse of +camelcase+. Makes an underscored of a camelcase string.
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # Examples
  #   "SnakeCase".underscore           #=> "snake_case"
  #   "Snake-Case".underscore          #=> "snake_case"
  #   "SnakeCase::Errors".underscore   #=> "snake_case/errors"
  #
  def underscore
    gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

end

