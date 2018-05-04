#translates to an array easily
#keep track of nodes in 0(n) time
#class methods
  #point: to operate on an array independent of the data structure
  #give a proc to compare the data and then organize as we want it
  #max heap proc or min heap proc
  #how compare children of tree structure and conver to incices of the array


class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
  end

  def count
    store.length
  end

  def extract
    raise "no element to extract" if count == 0
    val = @store[0]
    if count > 1
      @store[0] = @store.pop
      
    else
      @store.pop
    end
    # @store[0], @store[-1] = @store[-1], @store[0]
    # max = @store.pop
    # self.class.heapify_down(@store, @store[0], len = @store.length, &prc)
    # max
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, count - 1, len = @store.length, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    child1 = (parent_index * 2) + 1
    child2 = (parent_index * 2) + 2
    if child2 > (len - 1)
      return [child1]
    else
      return [child1, child2]
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    child_idx1, child_idx2 = child_indices(len, parent_idx)

    parent_val = array[parent_idx]

    children =[]
    children << array[child_idx1] if child_idx1
    children << array[child_idx2] if child_idx2

    if children.all? { |child| prc.call(parent_val, child) <= 0}
      return array
    end

    swap_idx = nil
    if children.length == 1
      swap_idx = child_idx1
    else
      swap_idx = prc.call(children[0], children[1]) == -1 ? child_idx1 : child_idx2
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end

  #   return if child_idx1 == 0
  #   return if child_idx2 > len
  #   return if array[child_idx1] == nil || array[child_idx2] == nil
  #
  #   res = prc.call(array[child_idx1], array[child_idx2])
  #   smallest_child = (res == -1 ? child_idx1 : child_idx2)
  #   result = prc.call(array[parent_idx], array[smallest_child])
  #   if result == 1
  #     array[parent_idx], array[smallest_child] = array[smallest_child], array[parent_idx]
  #     heapify_down(array, smallest_child, array.length, &prc)
  #   end
  #   array
  # end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    result = prc.call(array[parent_idx], array[child_idx])
    if result == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, array.length, &prc)
    end
    array
  end
end
