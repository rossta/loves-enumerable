require "benchmark/ips"

file = File.open(File.expand_path("../../data/Thriller.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z']{2,16}\b}i)

Benchmark.ips do |x|
  x.report("each") do
    histogram = {}
    words.each do |w|
      histogram[w] ||= 0
      histogram[w] += 1
    end
  end

  x.report("reduce") do
    words.reduce(Hash.new(0)) { |hist, n| hist[n] += 1; hist }
  end

  x.report("each_with_object") do
    words.each_with_object(Hash.new(0)) { |n, hist| hist[n] += 1 }
  end

  x.report("group_by + flat_map") do
    Hash[*words.group_by { |w| w }.flat_map { |k, v| [k, v.size] }]
  end

  x.compare! # Output the comparison
end
