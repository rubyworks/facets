if defined?(Enumerator::Lazy)
  class Enumerator
    class Lazy

      # Enumerator::Lazy version of Enumerable#squeeze.
      # Note: you must use Ruby 2.0+ or require 'backports'.
      # For now, you have to require 'facets/enumerator/lazy/squeeze' explicitly.
      #
      # Examples
      #
      #   [1,2,2,3,3,2,1].lazy.squeeze.to_a #=> [1,2,3,2,1]
      #
      # Returns Enumerator::Lazy.
      #
      # CREDIT: T. Yamada

      def squeeze(*other_elem)
        first = true
        cur = nil
        self.class.new(self) do |y,v|
          if !other_elem.empty? && !other_elem.include?(v)
            y << v
          elsif first || cur != v
            y << v
            first = false
            cur = v
          end
        end
      end
    end
  end
end
