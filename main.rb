class LinkedList

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    #adds a new node containing #value to the end of the list
    if @head == nil
      @head = Node.new(value) 
      @tail = @head
    else
      self.insert_at(value, size())
    end
  end

  def prepend(value)
    #adds a new node containing #value to the beginning of the list
    if @tail == nil
      @head = Node.new(value) 
      @tail = @head
    else
      self.insert_at(value, 0)
    end
  end

  def size()
    #returns the count of nodes in list
    return 0 if @head == nil
    counter = 1
    node = self.head()
    until node.next_node == nil do
      counter += 1
      node = node.next_node
    end
    return counter
  end

  def head()
    #returns the first node in the list
    @head
  end

  def tail()
    #returns the last node in the list
    @tail
  end

  def at(index)
    #returns the node at the given #index
    return "nil" if index > size() - 1 || index < 0
    counter = 0
    node = self.head()
    while counter < index do
      counter += 1
      node = node.next_node
    end
    return node
  end

  def pop()
    #removes the last element from the list
    return puts "Error: list is empty" if empty?
    remove_at(size()-1)
  end

  def contains?(value)
    #returns true if the #value exists in the list, false otherwise
    counter = 1
    node = self.head()
    until counter > size() do
      return true if node.value == value
      node = node.next_node
      counter += 1
    end
    false
  end

  def find(value)
    #returns the index of the #value if found in the array, nil otherwise
    counter = 0
    node = self.head()
    until node.next_node == nil do
      return counter if node.value == value
      node = node.next_node
      counter += 1
    end
    nil
  end

  def to_s()
    #represent list as string
    #( value ) -> ( value ) -> ( value ) -> nil
    return nil if empty?
    string = ""
    node = self.head()
    until node.next_node == nil do
      string += "( #{node.value} ) --> "
      node = node.next_node
    end
    string += "( #{node.value} ) --> nil"
  end

  def insert_at(value, index = nil)
    return puts "Error syntax: \"insert_at(index)\"" if index == nil
    #inserts a new node with the provided #value at the given #index
    size = size()
    newNode = Node.new(value)

    nextNode = at(index) unless index == size
    prevNode = at(index-1) unless index == 0

    nextNode.prev_node = newNode unless index == size
    newNode.next_node = nextNode unless index == size

    prevNode.next_node = newNode unless index == 0
    newNode.prev_node = prevNode unless index == 0
    
    @head = newNode if newNode.prev_node == nil
    @tail = newNode if newNode.next_node == nil
  end

  def remove_at(index = nil)
    return puts "Error syntax:\"remove_at(index)\"" if index == nil
    return initialize() if size() <= 1
    #removes the node at the given #index
    node = at(index)
    size = size()
    nextNode = at(index+1) unless index == size-1
    prevNode = at(index-1) unless index == 0
    
    index == size-1 ? prevNode.next_node = nil : nextNode.prev_node = prevNode
    index == 0 ? nextNode.prev_node = nil : prevNode.next_node = nextNode

    @head = nextNode if node.prev_node == nil
    @tail = prevNode if node.next_node == nil
  end

  def empty?()
    size() == 0
  end

end

class Node
  attr_accessor :value
  attr_accessor :next_node
  attr_accessor :prev_node

  def initialize(value = nil, nextNode = nil, prevNode = nil)
    @value = value
    @next_node = nextNode
    @prev_node = prevNode
  end

end
