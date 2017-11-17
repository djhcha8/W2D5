require "byebug"
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
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end 

class LinkedList
  attr_reader :head, :tail
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == tail
  end

  def get(key)
    # debugger
    self.each {|node| return node.val if node.key == key}
  end

  def include?(key)
    self.each {|node| return true if node.key == key}
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = tail
    new_node.prev = tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
    
  end

  def update(key, val)
    self.each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    removing_node = nil
    self.each { |node| removing_node = node if node.key == key }
    removing_node.next.prev = removing_node.prev
    removing_node.prev.next = removing_node.next
  end

  def each(&prc)
    curr_node = self.first
    until curr_node.next == nil
      prc.call(curr_node)
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
