module Enumerable

  # The block acts as an arbitrary filter on the data. Unlike
  # map, it can choose to drop elements from the result, and/or add
  # additional ones. The first object passed to the block is the receiver
  # of the output.
  #
  #   (1..1_000_000_000).
  #     filter { |out,i| out << i if i % 2 == 0 }.  # like select
  #     filter { |out,i| out << i + 100 }.          # like map
  #     take(10).each { |i| puts i }
  #
  def filter(output=[])
    if block_given?
      each do |*input|
        yield(output, *input)
      end
      output
    else
      to_enum(:filter)
    end
  end

end

