require "benchmark/ips"
require "montrose"

TIMES = Montrose.every(2.weeks, on: :tuesday, at: "12pm").take(25)

Benchmark.ips do |x|
  x.report("group_by month") do
    TIMES.group_by(&:month)
  end

  x.report("chunk months as hash like group_by") do
    TIMES.chunk(&:month).to_h
  end

  x.compare! # Output the comparison
end

Benchmark.ips do |x|
  x.report("group_by month to array") do
    TIMES.group_by(&:month).to_a
  end

  x.report("chunk months to array") do
    TIMES.chunk(&:month).to_a
  end

  x.compare! # Output the comparison
end

# Results:
# MacBook Pro (15-inch, Early 2011)
# Processor 2GHz Intel Core i17
# Memory 8 GB 1333 MHz DDR3
#
# $ ruby -v
# ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin14]
#
# $ ruby code/benchmark_group_by_vs_chunk.rb
# Calculating -------------------------------------
#       group_by month     7.111k i/100ms
# chunk months as hash like group_by
#                          3.704k i/100ms
# -------------------------------------------------
#       group_by month    103.224k (±15.7%) i/s -    504.881k
# chunk months as hash like group_by
#                          43.253k (±16.0%) i/s -    211.128k
#
# Comparison:
#       group_by month:   103223.6 i/s
# chunk months as hash like group_by:    43252.6 i/s - 2.39x slower
#
# Calculating -------------------------------------
# group_by month to array
#                          6.248k i/100ms
# chunk months to array
#                          4.222k i/100ms
# -------------------------------------------------
# group_by month to array
#                          81.505k (±15.8%) i/s -    399.872k
# chunk months to array
#                          54.314k (±10.5%) i/s -    270.208k
#
# Comparison:
# group_by month to array:    81504.5 i/s
# chunk months to array:    54313.9 i/s - 1.50x slower
