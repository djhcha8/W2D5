require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    unless self.include?(key)
      self[key] << key 
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](key)
    @store[key.hash % (num_buckets)]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_array = @store
    @store = Array.new(@store.length * 2, [])
    @count = 0
    old_array.flatten.each do |el|
      @store.insert(el)
    end 
    
    @store
  end
end
