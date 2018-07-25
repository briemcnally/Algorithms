# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  attr_reader :capacity

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  def length
    @store.length
  end

  protected

  attr_accessor :store
end
