class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot_array = [array[0]]

    left = array[1..-1].select{|el| el < array.first}
    right = array[1..-1].select{|el| el >= array.frst}

    quick_sort(left) + pivot_array + quick_sort(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)
    left_length = pivot_idx - start
    right_length = length - (left_length + 1)

    self.sort2!(array, start, left_length, &prc)
    self.sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot_idx, pivot = start, array[start]
    ((start + 1)...(start+length)).each do |idx|
      val = array[idx]
      if prc.call(pivot, val) == 1
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = val
        pivot_idx += 1
      end
    end
    return pivot_idx
  end
end
