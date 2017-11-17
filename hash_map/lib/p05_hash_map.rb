require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.each do |bucket|
      bucket.each do |node|
        return true if node.key == key
      end 
    end 
    false
  end

  def set(key, val)
    resize! if count == num_buckets
    
    buck = bucket(key)
    if self.include?(key)
      @store[buck].update(key, val)
    else 
      @store[buck].append(key, val)
      @count += 1
    end
  end

  def get(key)
    result = nil
    @store.each do |bucket|
      bucket.each do |node|
        result = node.val if node.key == key
      end 
    end 
    result
  end 

  def delete(key)
    buck = bucket(key)
    @store[buck].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end 
    end 

  end
  
  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # old_array = @store
    # @store = Array.new(@store.length * 2, LinkedList.new)
    # @count = 0
    # old_array.each do |bucket|
    #   bucket.each do |node|
    #     self.set(node)
    #   end 
    # end 
    # self
  end

  def bucket(key)
    # debugger
    key.hash % num_buckets
    # optional but useful; return the bucket corresponding to `key`
  end
end
