require "byebug"

def quick_sort(array)

  return array if array.length < 2

  pivot = array[0]
  left = []
  right = []

  array[1..-1].each do |el|
    left << el if el <= pivot
    right << el if el > pivot
  end

  quick_sort(left) + [pivot] + quick_sort(right)

end


a = [4, 1, 3, 20, 50, 7, 9, 2, 1, 1]

puts quick_sort(a).to_s
