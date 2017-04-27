require 'pry'

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(node)
    @size += 1

    if @head.nil?
      @head = node
    else
      @tail.next_node = node
    end

    @tail = node
  end

  def prepend(node)
    @size += 1

    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def indexed_list
    indexed_list = {}
    node = @head

    @size.times do |idx|
      indexed_list[idx] = node
      node = node.next_node
    end

    indexed_list
  end

  def at(index)
    return if index >= @size
    indexed_list[index]
  end

  def pop
    old_tail = @tail
    new_tail = at(@size - 2)

    return if new_tail.nil?
    new_tail.next_node = nil

    @tail  = new_tail
    @size -= 1

    old_tail
  end

  def contains?(value)
    indexed_list.any? { |_key, node| node.value == value }
  end

  def find(data)
    result = indexed_list.select { |i, node| return i if node.value == data }
    result.empty? ? nil : result
  end

  def to_s
    indexed_list.values.each do |node|
      print "( #{node.value} )"
      print " -> "
      print "nil\n" if node.next_node.nil?
    end
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value     = value
    @next_node = nil
  end
end

list = LinkedList.new
list.append(Node.new(3))
list.append(Node.new(5))
list.append(Node.new(6))
list.prepend(Node.new(1))
list.append(Node.new(9))
list.at(4)

p list.head
p list.tail

p list.contains?(9)
p list.find(9)
p list.find(10)

p list.size
p list.tail
p list.pop

p list.size
p list.tail
p list.pop

puts list # => ( 1 ) -> ( 3 ) -> ( 5 ) -> nil
