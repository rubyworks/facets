# Lets a test see the warnings a block raises, including the deprecation
# warnings that etc/quiet_deprecations.rb would hide.
#
#   warnings = WarningRecorder.record { {a: 1}.count(1) }
#   warnings.size.assert == 1
#
# Loaded by etc/test.rb, after quiet_deprecations.rb, so it sees each
# warning first.
module WarningRecorder
  # Run the block and return the warning messages it raised, without
  # printing them.
  def self.record
    @messages = []
    yield
    @messages
  ensure
    @messages = nil
  end

  def self.messages
    @messages
  end

  def warn(message, *args, **opts)
    messages = WarningRecorder.messages
    return super unless messages
    messages << message
    nil
  end
end

Warning.extend(WarningRecorder)
