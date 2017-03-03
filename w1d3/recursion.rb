

require 'byebug'

def range(start, last)
  return [] if last < start
  return [start] if start == last

  [start] + range(start + 1, last)
end

def sum_array(array)
  sum = 0
  array.each do |num|
    sum += num
  end
  sum
end

def sum_array_recursive(array)
  return array[0] if array.length == 1

  array[0] + sum_array_recursive(array[1..-1])
end

def exp_recursion1(b, n)
  return 1 if n == 0
  b * exp_recursion1(b, n - 1)
end

def exp_recursion2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    sol = exp_recursion2(b, (n / 2))
    sol * sol
  else
    sol = exp_recursion2(b, ((n - 1) / 2))
    b * (sol * sol)
  end
end

def deep_dup(array)
    duplicated_array = []

    array.each do |el|
      if el.is_a?(Array)
        duplicated_array << deep_dup(el)
      else
        duplicated_array << el
      end
    end

    duplicated_array
  end


def fib_num_recursive(n)
  return [1] if n == 1
  return [1, 1] if n == 2

  previous_fib = fib_num(n - 1)
  previous_fib + [(previous_fib[-2] + previous_fib[-1])]
end


def fib_num_iterative(n)
  result = [1, 1]
  n.times do |x|
    if x > 1
      result << (result[-1] + result[-2])
    end
  end
  result
end

def subset(array)
  return [[], array] if array.length == 1

  subs = subset(array[1..-1])
  subs + deep_dup(subs).map { |x| x.unshift(array[0]) }
end

def permutations(array)

  return [array, array.reverse] if array.length == 2

  sub_perms = []

  array.each_with_index do |el, idx|
    duplicate_array = deep_dup(array)
    duplicate_array.slice!(idx)
    sub_arrays = permutations(duplicate_array)
    sub_perms += sub_arrays.map { |x| x.unshift(el) }
  end

  sub_perms
end


def binary_search(array, target)

  case
  when array.length == 1 && array[0] != target
    return nil
  when array[0] == target
    return 0
  when array.length == 2
    pivot = 0
    left_array = []
  when array.length > 2
    pivot = array.length / 2
    left_array = array[0..(pivot - 1)]
  end

  right_array = array[(pivot + 1)..-1]

  if array[pivot] == target
    pivot
  elsif array[pivot] > target
    binary_search2(left_array, target)
  elsif array[pivot] < target
    right_search = binary_search2(right_array, target)
    return nil if right_search.nil?
    right_search + left_array.length + 1
  end
end

def merge_sort(array)

  return array unless array.is_a?(Array)

  if array.length > 2
    pivot = array.length / 2
    left_side = array[0..pivot]
    right_side = array[(pivot + 1)..-1]
  else
    left_side = array[0]
    right_side = array[1]
  end

  searched_left = merge_sort(left_side)
  searched_right = merge_sort(right_side)

  merge_helper(searched_left, searched_right)
end

def merge_helper(array1, array2)
  combined_array = []

  array1 || array1 = []
  array2 || array2 = []

  array1 = [array1] unless array1.is_a?(Array)
  array2 = [array2] unless array2.is_a?(Array)

  until array1.empty? || array2.empty?
    if array1[0] < array2[0]
      combined_array << array1.shift
    elsif array2[0] < array1[0]
      combined_array << array2.shift
    end
  end

  combined_array += array1 if array2.empty?
  combined_array += array2 if array1.empty?

  combined_array
end


def greed_make_change(amount, coins = [25, 10, 5, 1])
  result = []
  return [] if amount == 0

  coins.each do |coin|
    if amount >= coin
      result << coin
      amount -= coin
      change = greed_make_change(amount, coins)
      amount -= change.inject(:+) unless change.empty?
      return result + change
    end
  end
  []
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  possible_combos = []
  return [] if amount == 0

  coins.each do |coin|

    temp_amount = amount
    if temp_amount >= coin
      temp_amount -= coin
      change = make_better_change(temp_amount, coins.reject { |x| x > coin } )
      possible_combos << [coin] + change
      temp_amount -= change.inject(:+) unless change.empty?
    end
  end

    possible_combos.sort_by! { |x| x.length }.first
end

# BONUS RECURSIVE QUESTIONS

def sum_recur(array)
  return array[0] if array.length == 1

  array[0] + sum_recur(array[1..-1])
end

def includes?(array, target)
  return true if array[0] == target
  return false if array.length == 1

  includes?(array[1..-1], target)
end

def num_occur(array, target)
  return 0 if array.length == 1 && array[0] != target
  return 1 if array[0] == target && array.length == 1
  result = 0
  result += 1 if array[0] == target
  result += num_occur(array[1..-1], target)
  result
end

def add_to_twelve?(array)
  return false if array.length < 2
  return array[0] + array[1] == 12 if array.length == 2

  first_pair = array[0]
  second_pair = array[1]
  return true if first_pair + second_pair == 12

  add_to_twelve?(array[1..-1])
end

def sorted?(array)
  return false if array.length < 2
  return array[0] <= array[1] if array.length == 2

  return false if array[0] > array[1]
  sorted?(array[1..-1])
end


def reverse(string)
  return string if string.length == 1

  string[-1] + reverse(string[0..-1])
end

puts permutations(["x", "x", "y", "z"]).to_s == permutations(["x", "x", "y", "z"]).uniq.to_s
