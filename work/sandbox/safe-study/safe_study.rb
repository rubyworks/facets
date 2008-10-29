
  class X
    def yo=x; @yo=x; end
  end

  class Y
    def yo!; puts @yo; end
  end

  x = X.new

  class << x; Y.instance_methods.each {|m| define_method m, Y.instance_method(m)}; end 

  x.yo = "Hello World"
  x.yo!

