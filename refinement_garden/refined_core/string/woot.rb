module RefinedCore
  module String
    module Woot
      refine String do
        include Common::String::Woot
      end
    end
  end
end
