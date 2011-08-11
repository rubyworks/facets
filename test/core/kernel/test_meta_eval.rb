covers 'facets/kernel/meta_eval'

test_case Kernel do

  method :meta_eval do

    test do
      o = Object.new
      o.meta_eval do
        @y = "y"
      end
      o.instance_variable_get("@y").refute == "y"
      (class << o; self; end).instance_variable_get("@y").assert == "y"
    end

  end

end
