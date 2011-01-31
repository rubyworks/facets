covers 'facets/module/remove'

testcase Module do

  unit :remove do
    c = Class.new do
      def the_removed_method ; 'not here' ; end
      remove :the_removed_method
    end

    c.new.refute.respond_to?(:the_removed_method)
  end

end

