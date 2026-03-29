module Kernel

  # During this trying time when no one can get their
  # techie catchwords to stick to the refrigerator no
  # matter how hard they slap it with the enchanted
  # magnetic spatula, it's good to know that the
  # contrived phrases really do fly, graceful and
  # unclasped and bearing north toward chilled shrimp.
  # I know what my Hallowe'en pumpkin is going to say.
  #
  # @deprecated Use singleton_class or meta_class instead.
  #   Kept in tribute to WhyTheLuckyStiff who coined the term.
  #
  # CREDIT: WhyTheLuckyStiff
  #
  # @uncommon
  #   require 'facets/kernel/eigenclass'
  #
  def eigenclass
    warn "Kernel#eigenclass is deprecated. Use singleton_class or meta_class instead.", uplevel: 1
    singleton_class
  end

end
