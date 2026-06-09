covers 'facets/module/mattr'

test_case Module do

  method :cattr_reader do

    test "uses a block default" do
      c = Class.new do
        cattr_reader(:setting) { :default }
      end

      c.setting.assert == :default
      c.new.setting.assert == :default
    end

    test "does not replace an existing value" do
      c = Class.new do
        class_variable_set(:@@existing_cattr_reader_setting, :existing)
        cattr_reader(:existing_cattr_reader_setting) { :default }
      end

      c.existing_cattr_reader_setting.assert == :existing
    end

  end

  method :cattr_writer do

    test "uses a block default for writer-only attributes" do
      c = Class.new do
        cattr_writer(:setting) { :default }
      end

      c.class_variable_get(:@@setting).assert == :default
      c.setting = :changed
      c.class_variable_get(:@@setting).assert == :changed
    end

  end

  method :cattr_accessor do

    test "uses a block default once" do
      calls = 0
      c = Class.new do
        cattr_accessor(:cattr_accessor_setting) do
          calls += 1
          :default
        end
      end

      c.cattr_accessor_setting.assert == :default
      c.new.cattr_accessor_setting.assert == :default
      calls.assert == 1
    end

  end

  method :mattr_reader do

    test "uses a block default" do
      c = Class.new do
        mattr_reader(:setting) { :default }
      end

      c.setting.assert == :default
      c.new.setting.assert == :default
    end

    test "does not replace an existing value" do
      c = Class.new do
        class_variable_set(:@@existing_mattr_reader_setting, :existing)
        mattr_reader(:existing_mattr_reader_setting) { :default }
      end

      c.existing_mattr_reader_setting.assert == :existing
    end

  end

  method :mattr_writer do

    test "uses a block default for writer-only attributes" do
      c = Class.new do
        mattr_writer(:setting) { :default }
      end

      c.class_variable_get(:@@setting).assert == :default
      c.setting = :changed
      c.class_variable_get(:@@setting).assert == :changed
    end

  end

  method :mattr_accessor do

    test "uses a block default once" do
      calls = 0
      c = Class.new do
        mattr_accessor(:mattr_accessor_setting) do
          calls += 1
          :default
        end
      end

      c.mattr_accessor_setting.assert == :default
      c.new.mattr_accessor_setting.assert == :default
      calls.assert == 1
    end

  end

end
