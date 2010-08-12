module Kernel

  #
  # CREDIT: Trans

  def disable_warnings #:yield:
    verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = verbose
  end

  #
  # CREDIT: Trans

  def enable_warnings #:yield:
    verbose, $VERBOSE = $VERBOSE, true
    yield
  ensure
    $VERBOSE = verbose
  end

end
