covers 'facets/module/mattr'

test_case Module do

  method :cattr_reader do

    test do
      c = Class.new do
        cattr_reader(:setting) { :default }
      end

      c.setting.assert == :default
      c.new.setting.assert == :default
    end

  end

  method :cattr_accessor do

    test do
      c = Class.new do
        cattr_accessor(:setting) { :default }
      end

      c.setting.assert == :default
      c.setting = :changed
      c.new.setting.assert == :changed
    end

  end

  method :mattr_reader do

    test do
      c = Class.new do
        mattr_reader(:setting) { :default }
      end

      c.setting.assert == :default
      c.new.setting.assert == :default
    end

  end

  method :mattr_accessor do

    test do
      c = Class.new do
        mattr_accessor(:setting) { :default }
      end

      c.setting.assert == :default
      c.setting = :changed
      c.new.setting.assert == :changed
    end

  end

end
