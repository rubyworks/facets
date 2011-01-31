module Kernel

  #
  # CREDIT: Trans

  def disable_warnings #:yield:
    verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = verbose
  end

  # DEPRECATE: Use #disable_warnings instead.
  alias_method :silence_warnings, :disable_warnings

  #
  # CREDIT: Trans

  def enable_warnings #:yield:
    verbose, $VERBOSE = $VERBOSE, true
    yield
  ensure
    $VERBOSE = verbose
  end

end
