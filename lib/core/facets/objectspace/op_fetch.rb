class << ObjectSpace
  # Ruby 4.1 removed ObjectSpace._id2ref, so there is nothing to alias there.
  alias_method :[], :_id2ref if method_defined?(:_id2ref)
end
