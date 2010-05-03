require 'facets/string/snakecase'

Case String do

  Unit :snakecase do
    '/my_module/my_class/'.snakecase.assert == '/my_module/my_class/'
    'MyModule::MyClass'.snakecase.assert == 'my_module/my_class'
    '::MyClass'.snakecase.assert == '/my_class'
    'URI'.snakecase.assert == 'uri'
  end

end

