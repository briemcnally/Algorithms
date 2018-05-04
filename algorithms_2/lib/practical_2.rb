# given a doubly linked list, reverse it.
# you can assume this method is monkey patching the linkedlist class that you built
# so any methods and instance variables in that class are available to you
class LinkedList
  def reverse
    org_first = first
    pointer = @head
    until orig_first == last
      new_first = last
      new_last = last.prev
      pointer.next = new_first
      new_first.prev = pointer
      new_last.next = @tail
      @tail.prev = new_last

      pointer = new_first
    end

    pointer.next = last
    last.prev = pointer 
  end
end
