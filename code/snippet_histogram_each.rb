file = File.open(File.expand_path("../../data/Thriller.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z']{2,16}\b}i)

puts words.inspect

histogram = {}
words.each do |w|
  histogram[w] ||= 0
  histogram[w] += 1
end

puts histogram.sort_by { |k, v| -v }.take(6).to_h

words = ["it's", "close", "to", "midnight", "and", "something", "evil's", "lurking", "in", "the", "dark"]

{"the"=>29, "you"=>23, "thriller"=>20, "and"=>14, "to"=>12, "night"=>10, ...}
