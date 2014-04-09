module Kernel

  # During this trying time when no one can get their
  # techie catchwords to stick to the refrigerator no
  # matter how hard they slap it with the enchanted
  # magnetic spatula, it’s good to know that the
  # contrived phrases really do fly, graceful and
  # unclasped and bearing north toward chilled shrimp.
  # I know what my Hallowe’en pumpkin is going to say.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using `require 'facets'`.
  #
  # CREDIT: WhyTheLuckyStiff
  #
  # @uncommon
  #   require 'facets/kernel/eigenclass'
  #
  def eigenclass
    (class << self; self; end)
  end

end

