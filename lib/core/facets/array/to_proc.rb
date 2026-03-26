class Array

  # Converts an associative array of method names and arguments
  # to a Proc making chained calls on a given object.
  #
  # Examples
  #
  #     [:to_i, :next, [:*, 2]].to_proc.call("2")
  #     # => 6
  #
  #     # Create a proc which calls "obj[1].is_a?(String)":
  #     chain = [[:[], 1], [:is_a?, String]]
  #     chain.to_proc
  #
  #     the_hash = { one: "One", two: "Two", three: 3, four: nil }
  #     the_hash.select(&chain)
  #     # => { :one => "One", :two => "Two" }
  #
  #     mapping = { "one" => "1", "two" => "2", "" => "0" }
  #     the_hash.values.map(&[:to_s, :downcase, [:sub, /one|two|$^/, mapping]])
  #     # => ["1", "2", "3", "0"]
  #
  # Returns [Proc]
  #
  # :call-seq:
  #   [].to_proc
  #   &[:method1, [:method2, *args], [:method3, ...]]
  #

  def to_proc
    proc do |*obj|
      obj = obj.shift if obj.size == 1
      reduce(obj) { |chain, (mth, *args)| chain.public_send(mth, *args) }
    end
  end unless method_defined?(:to_proc)
end