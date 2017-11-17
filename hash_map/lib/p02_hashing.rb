require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    number = 0
    self.each_with_index do |el, idx|
      number += ((el.hash + idx.hash) % 12)
    end 
    number
  end
end

class String
  def hash
    result = 0
    arr = self.chars
    arr.each_with_index do |ch, idx|
      result += ((ch.ord).hash + idx.hash) % 12
    end 
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.sort.each_with_index do |arr, idx|
      result += (arr[1].hash + idx.hash) % 12
    end 
    result
  end
end
