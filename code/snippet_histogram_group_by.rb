file = File.open(File.expand_path("../../data/Thriller.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z']{2,16}\b}i)

histogram = Hash[*words.group_by { |w| w }.flat_map { |k, v| [k, v.size] }]

puts histogram.sort_by { |k, v| -v }.take(6).to_h

# {"know"=>12, "believe"=>10, "easier"=>5, "when"=>5, "much"=>4, "could"=>4}
