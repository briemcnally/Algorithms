require_relative "static_array"
class DynamicArray
  include Enumerable
  attr_reader :count, :length, :capacity, :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
    @capacity = store.length
  end

  # O(1)
  def [](index)
    if index >= @count
      raise "index out of bounds"
    end

    @store[@start_idx + index]
  end

  def []=(index, value)
    if index == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[@start_idx + index] = value
  end

  def push(value)
    resize! if capacity == @count
    @store[@start_idx + @count] = value
    @count += 1
    self
  end

  def unshift(value)
    resize! if capacity == @count
    @start_idx = (@start_idx - 1)
    @store[@start_idx] = value
    @count += 1
    self
  end

  def pop
    raise "index out of bounds" if @count == 0
    last_item = @store[@start_idx + @count - 1]
    @count -= 1
    last_item
  end

  def shift
    raise "index out of bounds" if @count == 0
    @count -= 1
    first_item = @store[@start_idx]
    @start_idx = @start_idx + 1
    first_item
  end

  def each
    @count.times { |i| return self[i] }
  end

  alias_method :length, :count
  alias_method :size, :count

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |el, idx| new_store[idx] = el }

    @store = new_store
    @capacity = capacity * 2
    @start_idx = 0
  end
end
