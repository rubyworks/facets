require 'facets/kernel/meta_class'

module Kernel

  # Add method to a meta-class --i.e. a singleton method.
  #
  #   class X; end
  #   X.meta_def(:x){"x"}
  #   X.x  #=> "x"
  #
  # CREDIT: WhyTheLuckyStiff

  def meta_def( name, &block )
    meta_class do
      define_method( name, &block )
    end
  end

  alias_method :metadef, :meta_def

end

