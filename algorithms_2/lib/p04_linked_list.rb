class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    # self.val = nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    #sentinel nodes
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    self.empty? ? nil : @head.next
  end

  def last
    self.empty? ? nil : @tail.prev
  end

  def empty?
    @tail.prev == @head
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
  end

  def include?(key)
    self.any?{ |node| node.key == key }
  end

  def append(key, val)
    node = Node.new(key, val)

    @tail.prev.next = node
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev = node

    node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return node.val
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end

    nil
  end

  def each
    next_node = @head.next
    until next_node == @tail
      yield next_node
      next_node = next_node.next
    end
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
