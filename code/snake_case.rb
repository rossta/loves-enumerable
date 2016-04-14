module SnakeCase
  module Iterative
    module_function

    def path_count(m, n)
      row = [1] * (n+1)

      m.times do
        row = build_row(row)
      end

      row.last
    end

    def path_count_enum(m, n)
      pascal(n).take(m+1).last.last
    end

    def pascal(n)
      Enumerator.new do |y|
        row = [1] * (n+1)

        loop do
          y.yield(row)
          row = build_row(row)
        end
      end
    end

    def build_row(row)
      row.reduce([]) { |acc, p| acc << (p + acc.last.to_i)  }
    end
  end

  module Recursive
    module_function

    def path_count(m, n)
      return 1 if m == 0 || n == 0

      path_count(m-1, n) + path_count(m, n-1)
    end
  end

  module Bruteforce
    module_function

    def path_count(m, n)
      (0..(2**(m+n))).count { |x| x.to_s(2).chars.count("1") == n }
    end
  end

  module Factorial
    module_function

    def path_count(m, n)
      (m+n).downto(m+1).reduce(:*) / n.downto(1).reduce(:*)
    end
  end
end

if __FILE__ == $0
  require "benchmark/ips"

  Benchmark.ips do |x|
    x.report("snake case iterative") do
      SnakeCase::Iterative.path_count(10, 10)
    end

    x.report("snake case iterative with enumerator") do
      SnakeCase::Iterative.path_count_enum(10, 10)
    end

    x.report("snake case recursive") do
      SnakeCase::Recursive.path_count(10, 10)
    end

    x.report("snake case factorial") do
      SnakeCase::Factorial.path_count(10, 10)
    end

    x.report("snake case brute force") do
      SnakeCase::Bruteforce.path_count(10, 10)
    end

    x.compare!
  end

# Warming up --------------------------------------
# snake case iterative     5.444k i/100ms
# snake case iterative with enumerator
#                          4.523k i/100ms
# snake case recursive     6.000  i/100ms
# snake case factorial    41.874k i/100ms
# snake case brute force
#                          1.000  i/100ms
# Calculating -------------------------------------
# snake case iterative     55.953k (± 2.3%) i/s -    283.088k in   5.062138s
# snake case iterative with enumerator
#                          46.076k (± 2.0%) i/s -    230.673k in   5.008466s
# snake case recursive     60.104  (± 1.7%) i/s -    306.000  in   5.092882s
# snake case factorial    468.243k (± 2.6%) i/s -      2.345M in   5.011419s
# snake case brute force
#                           0.352  (± 0.0%) i/s -      2.000  in   5.686841s
#
# Comparison:
# snake case factorial:   468242.6 i/s
# snake case iterative:    55953.2 i/s - 8.37x slower
# snake case iterative with enumerator:    46075.9 i/s - 10.16x slower
# snake case recursive:       60.1 i/s - 7790.49x slower
# snake case brute force:        0.4 i/s - 1331405.90x slower
# Shared at: https://benchmark.fyi/d
end
