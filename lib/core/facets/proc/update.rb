class Proc

  # Alias for #call, allowing a Proc to be used as an Observer.
  #
  # Ruby's Observable module (now the `observer` gem, removed from
  # stdlib in Ruby 3.2) calls #update on observers. This alias
  # lets a Proc serve as an observer directly.
  #
  # TODO: Consider submitting a PR to the observer gem to include
  # this extension there instead.
  #
  # CREDIT: Tim Pease

  alias_method :update, :call

end
