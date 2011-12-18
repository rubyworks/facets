class Time

  # Tracks the elapse time of a code block.
  #
  #   e = Time.elapse { sleep 1 }
  #
  #   e.assert > 1
  #
  # CREDIT: Hal Fulton

  def self.elapse
    raise "Need block" unless block_given?
    t0 = now.to_f
    yield
    now.to_f - t0
  end

end
