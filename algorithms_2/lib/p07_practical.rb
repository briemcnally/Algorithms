require_relative 'p05_hash_map'
require 'byebug'

def can_string_be_palindrome?(string)
  #create a hash map
  #can't set a defauly value in hash map
  #iterate over a string, add to the count
  # store number of odd counts
  #iterate over the hash map
  hash_count = HashMap.new
  string.each_char do |ch|
    if hash_count[ch]
      hash_count[ch] += 1
    else
      hash_count[ch] = 1
    end
  end

  num_odds = 0
  hash_count.each do |letter, count|
    num_odds += 1 if count.odd?
    if string.length % 2 == 1
      return false  if num_odds > 0
    else
      return false if num_odds > 1
    end
    return true
  end

end


def even?(string)
  string.length % 2 == 0
end
