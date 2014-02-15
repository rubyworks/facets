covers 'facets/string/rotate'

test_case String do

  method :rotate do

    test 'rotates left' do
      'abcdefgh'.rotate(2).assert == 'cdefghab'
    end
    test 'rotates right' do
      'abcdefgh'.rotate(-2).assert == 'ghabcdef'
    end

  end

  method :rotate! do

    test 'rotates left' do
      s='abcdefgh'
      s.rotate!(2)
      s.assert == 'cdefghab'
    end
    test 'rotates right' do
      s='abcdefgh'
      s.rotate!(-2)
      s.assert == 'ghabcdef'
    end

  end

end
