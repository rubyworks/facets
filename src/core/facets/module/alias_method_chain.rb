class Module

  # Encapsulates the common pattern of ...
  #
  #   alias_method :foo_without_feature, :foo
  #   alias_method :foo, :foo_with_feature
  #
  # With this, you simply do ...
  #
  #   alias_method_chain :foo, :feature
  #
  # For example
  #
  #   class AliasMethodChainExample
  #     def foo 
  #       "foo"
  #     end
  #
  #     def foo_with_feature
  #       "foo!"
  #     end
  #
  #     alias_method_chain :foo, :feature
  #   end
  #
  # And both aliases are set up for you.
  #
  #   example = AliasMethodChainExample.new
  #   example.foo #=> "foo!"
  #   example.foo_without_feature #=> "foo"
  #
  # Query and bang methods (foo?, foo!) keep the same punctuation ...
  #
  #   alias_method_chain :foo?, :feature
  #
  # is equivalent to ...
  #
  #   alias_method :foo_without_feature?, :foo?
  #   alias_method :foo?, :foo_with_feature?
  #
  # so you can safely chain foo, foo?, and foo! with the same feature.
  #
  # CREDIT: Bitsweat, Rails Team

  def alias_method_chain(target, feature)
    # Strip out punctuation on predicates or bang methods since
    # e.g. target?_without_feature is not a valid method name.
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

