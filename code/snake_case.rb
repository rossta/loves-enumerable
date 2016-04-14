module SnakeCase
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

  module Recursive
    module_function

    def path_count(m, n)
      return 1 if m == 0 || n == 0

      path_count(m-1, n) + path_count(m, n-1)
    end
  end

  module Iterative
    module_function

    def path_count(h, w)
      row = [1] * (w+1)

      h.times do
        row = row.reduce([]) { |acc, p| acc << (p + acc.last.to_i)  }
      end

      row.last
    end
  end

  module Enumerative
    module_function

    def path_count(m, n)
      grid(m, n).drop(m-1).last.last
    end

    def grid(h, w)
      return to_enum(:grid, h, w) unless block_given?

      row = [1] * (w+1)
      yield row

      h.times do
        row = row.reduce([]) { |acc, p| acc << (p + acc.last.to_i)  }
        yield row
      end
    end
  end
end

if __FILE__ == $0
  require "benchmark/ips"

  Benchmark.ips do |x|
    x.report("snake case factorial") do
      SnakeCase::Factorial.path_count(10, 10)
    end

    x.report("snake case brute force") do
      SnakeCase::Bruteforce.path_count(10, 10)
    end

    x.report("snake case recursive") do
      SnakeCase::Recursive.path_count(10, 10)
    end

    x.report("snake case iterative") do
      SnakeCase::Iterative.path_count(10, 10)
    end

    x.report("snake case enumerative") do
      SnakeCase::Enumerative.path_count(10, 10)
    end

    x.compare!
  end
# $ ruby code/snake_case.rb
# Calculating -------------------------------------
# snake case factorial    34.658k i/100ms
# snake case brute force
#                          1.000  i/100ms
# snake case recursive     5.000  i/100ms
# snake case iterative     4.920k i/100ms
# snake case enumerative
#                          4.109k i/100ms
# -------------------------------------------------
# snake case factorial    456.100k (± 7.8%) i/s -      2.287M
# snake case brute force
#                           0.325  (± 0.0%) i/s -      2.000  in   6.161730s
# snake case recursive     50.084  (±10.0%) i/s -    250.000
# snake case iterative     52.616k (± 5.3%) i/s -    265.680k
# snake case enumerative
#                          42.875k (± 7.1%) i/s -    213.668k
#
# Comparison:
# snake case factorial:   456100.0 i/s
# snake case iterative:    52615.9 i/s - 8.67x slower
# snake case enumerative:    42874.6 i/s - 10.64x slower
# snake case recursive:       50.1 i/s - 9106.72x slower
# snake case brute force:        0.3 i/s - 1405090.92x slower
end
