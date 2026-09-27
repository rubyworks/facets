covers 'facets/rails_bridge'

require 'tmpdir'
require 'stringio'
require 'fileutils'

class RailsBridgeFixture
  def existing; :original; end
end

test_case Facets do

  class_method :rails_bridge do

    setup do
      @dir = Dir.mktmpdir
      File.write(File.join(@dir, 'rails_bridge_fixture.rb'), <<-RUBY)
        class RailsBridgeFixture
          def greet(name); "hi \#{name}"; end
        end
      RUBY
      $LOAD_PATH.unshift(@dir)
    end

    teardown do
      $LOAD_PATH.delete(@dir)
      FileUtils.rm_rf(@dir)
    end

    test "stub warns once, loads the file and retries the call" do
      Facets.rails_bridge(RailsBridgeFixture, 'rails_bridge_fixture', :greet)

      err = StringIO.new
      stderr, $stderr = $stderr, err
      begin
        RailsBridgeFixture.new.greet('bob').assert == 'hi bob'
        RailsBridgeFixture.new.greet('sue').assert == 'hi sue'
      ensure
        $stderr = stderr
      end

      err.string.scan("will no longer be loaded").size.assert == 1
      err.string.assert.include?("require 'rails_bridge_fixture'")
    end

    test "leaves already defined methods alone" do
      Facets.rails_bridge(RailsBridgeFixture, 'rails_bridge_fixture', :existing)
      RailsBridgeFixture.new.existing.assert == :original
    end

  end

end
