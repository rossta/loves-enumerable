require "benchmark/ips"
require "montrose"

TIMES = Montrose.every(2.weeks, on: :tuesday, at: "12pm").take(25)

Benchmark.ips do |x|
  x.report("chunk months as nested arrays") do
    TIMES.chunk(&:month).map(&:last).to_a
  end

  x.report("slice_when by month as nested arrays") do
    TIMES.slice_when { |a, b| a.month != b.month }.to_a
  end

  x.report("chunk_while by month as nested arrays") do
    TIMES.chunk_while { |a, b| a.month == b.month }.to_a
  end

  x.compare! # Output the comparison
end
