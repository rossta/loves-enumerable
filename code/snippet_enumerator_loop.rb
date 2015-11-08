# Infinite number generator
enum = Enumerator.new do |y|
  n = 0
  loop do
    y.yield n
    n += 1
  end
end

enum.each { |i| puts i }
