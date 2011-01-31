require 'timeout'  # for TimeoutError

# = Timer
#
# Provides a strightforward means for controlling time critical execution.
# Can be used as a "stop watch" timer or as a "time bomb" timer:
#
#   t = Timer.new(10) { raise TimeoutError, "timeout!" }
#   t.start
#     :      # done within 10sec timeout
#   t.stop
#   t.start
#     :
#   if condition then
#     t.reset       #--> restart timer
#   end
#
# A class method is also provided for easily timing the exectuion of a block.
#
#   Timer.time do |timer|
#    timer.total_time.round  #=> 0
#
#    sleep 1
#    timer.total_time.round  #=> 1
#
#    timer.stop
#    timer.total_time.round  #=> 1
#
#    sleep 1
#    timer.total_time.round  #=> 1
#
#    timer.start
#    timer.total_time.round  #=> 1
#
#    sleep 1
#    timer.total_time.round  #=> 2
#   end
#
# Thanks to Paul Brannan for TimeLimit and Minero Aoki for Timer.
# These two libraries served as models for building this class.

class Timer

  #
  def initialize(time_limit=nil, &block)
    # standard timer
    @start_time = nil
    @end_time = nil
    @total_time = 0
    @runnning = nil
    # for using time limit
    @time_limit = time_limit
    @on_timeout = block
    @current_thread = nil
    @timer_thread = nil
  end

  #
  attr_accessor :time_limit

  #
  def start_time
    @start_time
  end

  #
  def end_time
    @end_time
  end

  #
  def on_timeout( &block )
    if block then
      @on_timeout = block
      true
    else
      false
    end
  end

  # Start the timer.
  def start
    @running = true
    @start_time = Time.now

    limit if @time_limit

    self

    ##if block_given? then
    ##  begin
    ##    yield( self )
    ##  ensure
    ##    stop
    ##  end
    ##else
    ##  @time_limit
    ##end
  end

  # Establish a time limit on execution.
  def limit( time_limit=nil )
    if @time_limit || time_limit
      @current_thread = Thread.current
      @timer_thread = Thread.fork {
        sleep @time_limit
        if @on_timeout then
          @on_timeout.call @time_limit
        else
          @current_thread.raise TimeoutError, "#{@time_limit} seconds past"
        end
      }
    end
  end

  # Kill time limit thread, if any.
  def defuse
    if @timer_thread
      Thread.kill @timer_thread
      @timer_thread = nil
    end
  end

  # Stops timer and returns total time.
  # If timer was not running returns false.
  def stop
    if @running
      defuse
      # record running time
      @end_time = Time.now
      @running = false
      @total_time += (@end_time - @start_time)
    else
      nil
    end
  end

  # Stops and resets the timer. If the timer was running
  # returns the total time. If not returns 0.
  def reset
    if running?
      r = stop
    else
      r = 0
    end
    @total_time = 0
    return r
  end

  # Resets the time limit. Same as:
  #
  #   t.stop
  #   t.start
  #
  def reset_limit
    #stop
    #start
    defuse
    limit
  end

  # Queries whether the timer is still running.
  def running?
    return @running
  end

  # Queries whether the timer is still not running.
  def stopped?
    return !@running
  end

  # Queries total recorded time of timer.
  def total_time
    if running? then
      return @total_time + (Time.now - @start_time)
    else
      return @total_time
    end
  end

  # Takes a block and returns the total time it took to execute.
  def self.time
    yield( timer = Timer.new.start )
    return timer.total_time
  end

  # Timer::Dummy - Dummy Timer (i.e. no real time limit)
  #--
  # TODO: Timer::Dummy needs some work.
  #++
  class Dummy < self
    def start
      if block_given? then
        yield
      else
        time_limit()
      end
    end

    def stop
      false
    end
  end #class Dummy

end #class Timer

# Copyright (c) 2004 Thomas Sawyer (Ruby License)
