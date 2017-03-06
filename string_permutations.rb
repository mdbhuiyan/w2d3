require "byebug"

def string_permutations(string)
  return [string] if string.length == 1

  letters = string.split("")
  final_perms = []

  letters.each_with_index do |letter, idx|
    test_letters = letters.dup
    test_letters.delete_at(idx)

    perms = string_permutations(test_letters.join)

    final_perms += perms.map { |perm| perm = "#{letter}#{perm}" }
  end

  final_perms
end
