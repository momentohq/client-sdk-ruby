def generate_random_string(length = 8)
  chars = ('a'..'z').to_a
  Array.new(length) { chars.sample }.join
end
