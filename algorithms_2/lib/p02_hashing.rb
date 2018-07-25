class Fixnum
  # Fixnum#hash already implemented for you
  self.hash
end

class Array
  def hash
    result = 0
    self.each_with_index { |el, idx| result += (el.hash * (idx + 1)) }
    result
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    string_hash = []

    self.chars do |ch|
      string_hash << alphabet.find_index(ch)
    end

    string_hash.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.values.to_a.sort.hash
  end
end
