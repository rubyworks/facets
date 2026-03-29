class Module

  # @deprecated Use Module#prepend instead (built-in since Ruby 2.0).
  #
  # The alias_method_chain pattern has been superseded by Module#prepend,
  # which provides a cleaner way to wrap methods.
  #
  def alias_method_chain(target, feature)
    warn "Module#alias_method_chain is deprecated. Use Module#prepend instead.", uplevel: 1
    aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
    yield(aliased_target, punctuation) if block_given?

    with_method, without_method = "#{aliased_target}_with_#{feature}#{punctuation}", "#{aliased_target}_without_#{feature}#{punctuation}"

    alias_method without_method, target
    alias_method target, with_method

    case
      when public_method_defined?(without_method)
        public target
      when protected_method_defined?(without_method)
        protected target
      when private_method_defined?(without_method)
        private target
    end
  end

end
