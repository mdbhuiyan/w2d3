require 'byebug'

class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    selected = []
    self.my_each do |el|
      selected << el if prc.call(el)
    end
    selected
  end

  def my_reject(&prc)
    selected = []
    self.my_each do |el|
      selected << el if ! prc.call(el)
    end
    selected
  end

  def my_any?(&prc)
    flag = false
    self.my_each do |el|
      flag = true if prc.call(el)
    end
    flag
  end

  def my_all?(&prc)
    flag = true
    self.my_each do |el|
      flag = false if ! prc.call(el)
    end
    flag
  end

  def my_flatten
    flattened_array = []
    self.my_each do |el|
      flattened_array << el.my_flatten if el.is_a?(Array)
      flattened_array << el if el.is_a?(Integer)
    end
    flattened_array
  end

  def my_zip(*arrays)
    i = 0
    zipped_array = []
    self.length.times do
      zipped_sub = []
      zipped_sub << self[i]
      arrays.my_each do |array|
        zipped_sub << array[i]
        # zipped_sub << array[i] if ! arr[i].nil?
        # zipped_sub << nil if arr[i].nil?
      end
      zipped_array << zipped_sub
      i += 1
    end
    zipped_array
  end

  def my_rotate(n = 1)
    result = []
    n = n % self.length if n > self.length
    self.length.times do
      if n < self.length
        result << self[n]
      else
        n = n - self.length
        result << self[n]
      end
      n += 1
    end
    result
  end

  def my_join(joiner = "")
    result = ""
    self.my_each do |el|
      result += el + joiner
    end
    result.chomp(joiner)
  end

  def my_reverse
    result = []
    self.my_each do |el|
      result.unshift(el)
    end
    result
  end

  def bubble_sort!(&prc)
   loop do
     flag = true
     self.each_index do |i|
       if prc.call(self[i], self[i + 1]) == 1
         self[i], self[i + 1] = self[i + 1], self[i]
         flag = false
       end
     end
     break if flag
   end
   self
 end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

end # end class

def factors(num)
  i = 1
  factors_array = []
  while i <= num / 2
    factors_array << i if num % i == 0
    i += 1
  end
  factors_array
end

def substrings(string)
  subs = []
  string = string.split(//)
  string.each_index do |i|
    n = i
    while n < string.length
      subs << string[i..n].join("")
      n += 1
    end
  end
  subs
end

def subwords(string, dictionary)
  subs = []
  substrings(string).each do |substring|
    subs << substring if dictionary.include?(substring)
  end
  subs
end


# a = [1, 2, 3]
# puts a.my_select { |num| num > 1 }
# puts a.my_reject {|num| num > 1}
# puts a.my_any? {|num| num == 2}
# puts a.my_all? {|num| num == 2}
# puts [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# puts [1, 2, 3].my_zip(a, b).to_s # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# puts a.my_zip([1,2], [8]).to_s   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# puts [1, 2].my_zip(a, b).to_s
# a = [ "a", "b", "c", "d" ]
# puts a.my_rotate.to_s         #=> ["b", "c", "d", "a"]
# puts a.my_rotate(2).to_s      #=> ["c", "d", "a", "b"]
# puts a.my_rotate(-3).to_s
# puts a.my_rotate(15).to_s
# a = [ "a", "b", "c", "d" ]
# puts a.my_join         # => "abcd"
# puts a.my_join("$")    # => "a$b$c$d"
# puts [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# puts [ 1 ].my_reverse               #=> [1]
# puts factors(20)
# puts [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 }.to_s #sort ascending
# puts [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 }.to_s #sort descending
# puts [1, 3, 5].bubble_sort { |num1, num2| num1 <=> num2 }.to_s #sort ascending
# puts [1, 3, 5].bubble_sort { |num1, num2| num2 <=> num1 }.to_s #sort descending

# class Array
#
# end
#
# puts [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 }.to_s #sort ascending
# puts [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 }.to_s #sort descending
# puts subwords("cat", ["ca", "cat", "zzszsz"])
