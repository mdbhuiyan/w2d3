def sum_to(n)
  return 1 if n == 1
  return nil if n < 1
  n + sum_to(n - 1)
end

def add_numbers(array)
  return array[0] if array.length <= 1
  array[0] + add_numbers(array[1..-1])
end

def gamma_fnc(n)
  return nil if n < 1
  return 1 if n == 1
  n -= 1
  n * gamma_fnc(n)
end

def ice_cream_shop(flavors, favorite)
  return false if flavors.nil?
  return flavors[0] == favorite if flavors.length == 1
  if flavors[0] == favorite
    return true
  else
    ice_cream_shop(flavors[1..-1], favorite)
  end
end

def reverse(string)
  return string if string.length == 1
  string[-1] + reverse(string[0..-2])
end
