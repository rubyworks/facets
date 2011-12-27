covers 'facets/string/snakecase'

test_case String do

  method :snakecase do

    test 'dowcases' do
      'URI'.snakecase.assert == 'uri'
    end

    test 'converts spaces' do
      'MyStuff  HisStuff'.snakecase.assert == 'my_stuff_his_stuff'
    end

    test 'does not alter path dividers' do
      '/my_module/my_class/'.snakecase.assert == '/my_module/my_class/'
    end

  end

end

