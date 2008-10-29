# = Iteration
#
#

class It
  attr_reader :index, :value, :prior, :after
  def initialize(array)
    @array = array
    @index = 0
    @value = array[0]
    @prior = []
    @after = array[1..-1]
  end
  def first? ; @index == 0 ; end
  def last?
    if Enumerable === self
      nil
    else
      @index == @array.length
    end
  end
  private
  def next_iteration
    @index += 1
    @prior << @value
    @value = @after.shift
  end
end

class Array
  # Iterate over each element of array using an iteration object.
  #
  #   [1,2,3].each_iteration do |it|
  #     p it.index
  #     p it.value
  #     p it.first?
  #     p it.last?
  #     p it.prior
  #     p it.after
  #   end
  #
  # on each successive iteration produces:
  #
  #   0          1          2
  #   1          2          3
  #   true       false      false
  #   false      false      true
  #   []         [1]        [1,2]
  #   [2,3]      [3]        []
  #
  #  CREDIT: Trans

  def each_iteration
    if block_given?
      it = It.new(self)
      each do |e|
        yield(it)
        it.send(:next_iteration)
      end
    else
      return Enumerable::Enumerator.new(self, :each_iteration)
    end
  end
end

