require_relative "static_array"

class RingBuffer
  include Enumerable

  attr_reader :count, :store, :capacity

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
    @capacity = @store.length
  end

  # O(1)
  def [](index)
    if index >= @count
      raise "index out of bounds"
    end

    @store[(@start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, value)
    if index == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start_idx + index) % capacity] = value
  end

  # O(1)
  def pop
    raise "index out of bounds"  if @count == 0
    last_item = @store[(@start_idx + @count - 1) % capacity]
    @count -= 1
    last_item
  end

  # O(1) ammortized
  def push(val)
    resize! if capacity == @count
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
    self
  end

  # O(1)
  def shift
    raise "index out of bounds" if @count == 0
    @count -= 1
    first_item = @store[@start_idx]
    @start_idx = (@start_idx + 1) % capacity
    first_item
  end

  # O(1) ammortized
  def unshift(val)
    resize! if capacity == @count
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @count += 1
    self
  end

  def each
    @count.times { |i| yield self[i] }
    self
  end

  alias_method :length, :count
  alias_method :size, :count

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |el, i| new_store[i] = el }

    @store = new_store
    @capacity = capacity * 2
    @start_idx = 0
  end
end
