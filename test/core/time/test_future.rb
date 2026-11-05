covers 'facets/time/future'

test_case Time do

  method :future? do

    test do
      t = Time.now + 1000
      t.assert.future?
    end

    test do
      n = Time.now - 1000
      n.refute.future?
    end

    test do
      n = Time.now + 1001
      t = Time.now + 1000
      n.assert.future?(t)
    end

    test do
      n = Time.now + 999
      t = Time.now + 1000
      n.refute.future?(t)
    end

  end


  class_method :current do

    test "is now" do
      (Time.current - Time.now).abs.assert < 1
    end

    test "uses ActiveSupport's Time.zone when it's set" do
      zone = Object.new
      def zone.now = :zone_now
      Time.define_singleton_method(:zone) { zone }
      begin
        Time.current.assert == :zone_now
      ensure
        Time.singleton_class.send(:remove_method, :zone)
      end
    end

    test "ignores Time.zone when it's nil" do
      Time.define_singleton_method(:zone) { nil }
      begin
        Time.current.assert.is_a?(Time)
      ensure
        Time.singleton_class.send(:remove_method, :zone)
      end
    end

  end

end

