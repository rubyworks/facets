## Module#mattr

    require 'facets/module/mattr'

    c = Class.new do
      mattr :setting do
        :default
      end
    end

    c.setting.assert == :default
    c.new.setting.assert == :default

## Module#mattr_reader

    c = Class.new do
      mattr_reader(:setting) { :default }
    end

    c.setting.assert == :default
    c.new.setting.assert == :default

## Module#mattr_writer

    c = Class.new do
      mattr_writer(:setting) { :default }
    end

    c.class_variable_get(:@@setting).assert == :default
    c.setting = :changed
    c.class_variable_get(:@@setting).assert == :changed

## Module#mattr_accessor

    c = Class.new do
      mattr_accessor(:setting) { :default }
    end

    c.setting.assert == :default
    c.new.setting.assert == :default

Existing values are left in place.

    c = Class.new do
      class_variable_set(:@@setting, :existing)
      mattr_accessor(:setting) { :default }
    end

    c.setting.assert == :existing
