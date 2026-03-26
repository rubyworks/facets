class String

  # Dashcase a string such that camelcase, underscores and spaces are
  # replaced by dashes. This is similar to {#underscore},
  # but with dashes instead of underscores.
  #
  #   "DashCase".dashcase         #=> "dash-case"
  #   "Dash-Case".dashcase        #=> "dash-case"
  #   "Dash Case".dashcase        #=> "dash-case"
  #   "Dash  -  Case".dashcase    #=> "dash-case"

  def dashcase
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr('_', '-').
    gsub(/\s/, '-').
    gsub(/__+/, '-').
    downcase
  end

end
