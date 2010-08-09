Covers 'facets/proc/curry'

Case Proc do

  Unit :curry do
    f = Proc.new{ |a,b,c| a + b + c }
    c = f.curry
    c[1][2][3].assert == 6
  end

  Unit :curry => "with arguments" do
    f = Proc.new{ |a,b| a**b }
    c = f.curry(0)
    c[2][3].assert == 8

    f = Proc.new{ |a,b| a**b }
    c = f.curry(1)
    c[2][3].assert == 9
  end

  Unit :curry => "with in class scope" do
    # first test the lambda
    org = lambda{ |y, x| x + " " + y }
    foo = org.curry['yeah']
    foo['boo'].assert == 'boo yeah'

    # now test it as a method definition
    baz = Class.new
    baz.__send__(:define_method, 'foo', foo)
    baz.new.foo('boo').assert == 'boo yeah'
  end

end

