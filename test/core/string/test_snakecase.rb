covers 'facets/string/snakecase'

test_case String do

  method :snakecase do

    test do
      '/my_module/my_class/'.snakecase.assert == '/my_module/my_class/'
      'MyModule::MyClass'.snakecase.assert == 'my_module/my_class'
      '::MyClass'.snakecase.assert == '/my_class'
      'URI'.snakecase.assert == 'uri'
    end

  end

end

