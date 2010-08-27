covers 'facets/kernel/meta_eval'

tests Kernel do

  unit :meta_eval do
    o = Object.new
    o.meta_eval do
      @y = "y"
    end
    o.instance_variable_get("@y").refute == "y"
    (class << o; self; end).instance_variable_get("@y").assert == "y"
  end

end
