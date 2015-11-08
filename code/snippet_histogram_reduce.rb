file = File.open(File.expand_path("../../data/Old-Friend.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z]{4,16}\b}i)

histogram = words.reduce(Hash.new(0)) { |hist, n| hist[n] += 1; hist }

puts histogram.sort_by { |k, v| -v }.take(6).to_h

# {"know"=>12, "believe"=>10, "easier"=>5, "when"=>5, "want"=>4, "could"=>4}
