require_relative "heap"

class Array
  def heap_sort!
  #       1.upto(self.length - 1) do |i|
  #     #move up
  #     child = i
  #     while child > 0
  #       parent = (child - 1) / 2
  #       if self[parent] < self[child]
  #         self[parent], self[child] = self[child], self[parent]
  #         child = parent
  #       else
  #         break
  #       end
  #     end
  #   end
  #
  #   #sort
  #   i = self.length - 1
  #   while i > 0
  #     self[0], self[i] = self[i], self[0]
  #     i -= 1
  #
  #     #move down
  #     parent = 0
  #     while parent * 2 + 1 <= i
  #       child = parent * 2 + 1
  #       if child < i && self[child] < self[child + 1]
  #         child += 1
  #       end
  #       if self[parent] < self[child]
  #         self[parent], self[child] = self[child], self[parent]
  #         parent = child
  #       else
  #         break
  #       end
  #     end
  #   end
  end

  def heap_sort2!
    # heapify up
    2.upto(count).each do |heap_sz|
      BinaryMinHeap.heapify_up(self, heap_sz - 1)
    end
    count.downto(2).each do |heap_sz|
      self[heap_sz -1], self[0] = self[0], self[heap_sz - 1]
      BinaryMinHeap.heapify_down(self, 0,  heap_sz - 1)
    end

    self.reverse!

  end

  def max_heap_sort!
    prc ||= Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end

    pointer = 0

    while pointer < self.length
      BinaryMinHeap.heapify_up(self, pointer, &prc)
      pointer += 1
    end

    pointer -= 1

    while pointer >= 0
      self[0], self[pointer] = self[pointer], self[0]
      pointer -= 1
      BinaryMinHeap.heapify_down(self, 0, pointer + 1, &prc)
    end

    self
  end 
end
