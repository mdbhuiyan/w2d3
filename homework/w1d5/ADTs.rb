require 'byebug'

class Stack
  attr_reader :stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack.push(el)
  end

  def remove
    @stack.pop
  end

  def show
    puts stack
  end

end

class Queue
  attr_accessor :queue_line

  def initialize
    @queue_line = []
  end

  def add(el)
    queue_line.push(el)
  end

  def remove
    queue_line.shift
  end

  def show
    puts queue_line
  end
end


class Map
  attr_accessor :hash_map

  def initialize
    @hash_map = []
  end

  def assign(key, value)

    found_index = nil
    hash_map.each_with_index do |entry, idx|
      if entry[0] == key
        found_index = idx
      end
    end

    if found_index.nil?
      hash_map << [key, value]
    else
      hash_map[found_index][1] = value
    end
  end

  def lookup(key)
    hash_map.each do |entry|
      return entry[1] if entry[0] == key
    end
    nil
  end

  def remove(key)
    to_be_deleted = [key, lookup(key)]
    hash_map.reject { |entry| entry == to_be_deleted }
  end

  def show
    hash_map.each do |entry\
      puts "#{entry[0]} => #{entry[1]} ;"
    end
  end
  nil
end

m = Map.new
m.assign("a", 1)
m.assign("a", 2)
