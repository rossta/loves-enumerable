# * * * * *
# * * * * *
# * * * * *
# * * * * *
# * * * * *
#
# 1x1:2   2 * 1
# 2x2:6   3 * 2 * 1
# 3x3:20  5 * 4
# 4x4:70  5 * 4
# 5x5:252

module SnakeCase
  module Iterative
    module_function

    def path_count(m, n)
      row = [1] * (n+1)

      m.times do
        row = row.reduce([]) { |r, a| r << (a + r.last.to_i)  }
      end

      row.last
    end

    def path_count_2(m, n)
      pascal(n).take(m+1).last.last
    end

    def pascal(n)
      Enumerator.new do |y|
        row = [1] * (n+1)

        loop do
          y.yield(row)
          row = row.reduce([]) { |r, a| r << (a + r.last.to_i)  }
        end
      end
    end
  end

  module Recursive
    module_function

    def path_count(m, n)
      return 1 if m == 0 || n == 0

      path_count(m-1, n) + path_count(m, n-1)
    end
  end

  module Binary
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

require "benchmark/ips"
RubyVM::InstructionSequence.compile_option = {
  :tailcall_optimization => true,
  :trace_instruction => false
}

puts "Iterative"
puts SnakeCase::Iterative.path_count(2, 2)
puts SnakeCase::Iterative.path_count(3, 2)
puts SnakeCase::Iterative.path_count(4, 7)
puts SnakeCase::Iterative.path_count(10, 10)
puts "Iterative 2"
puts SnakeCase::Iterative.path_count_2(2, 2)
puts SnakeCase::Iterative.path_count_2(3, 2)
puts SnakeCase::Iterative.path_count_2(4, 7)
puts SnakeCase::Iterative.path_count_2(10, 10)
puts "Enumerable"
puts SnakeCase::Enumerable.path_count(2, 2)
puts SnakeCase::Enumerable.path_count(3, 2)
puts SnakeCase::Enumerable.path_count(4, 7)
puts SnakeCase::Enumerable.path_count(10, 10)
puts "Imperative"
puts SnakeCase::Imperative.path_count(2, 2)
puts SnakeCase::Imperative.path_count(3, 2)
puts SnakeCase::Imperative.path_count(4, 7)
puts SnakeCase::Imperative.path_count(10, 10)
puts "Recursive"
puts SnakeCase::Recursive.path_count(2, 2)
puts SnakeCase::Recursive.path_count(3, 2)
puts SnakeCase::Recursive.path_count(4, 7)
puts SnakeCase::Recursive.path_count(10, 10)
puts "Factorial"
puts SnakeCase::Factorial.path_count(2, 2)
puts SnakeCase::Factorial.path_count(3, 2)
puts SnakeCase::Factorial.path_count(4, 7)
puts SnakeCase::Factorial.path_count(10, 10)
puts "Binary"
puts SnakeCase::Binary.path_count(2, 2)
puts SnakeCase::Binary.path_count(3, 2)
puts SnakeCase::Binary.path_count(4, 7)
puts SnakeCase::Binary.path_count(10, 10)

Benchmark.ips do |x|
  x.report("snake case enumerable") do
    SnakeCase::Enumerable.path_count(10, 10)
  end

  x.report("snake case imperative") do
    SnakeCase::Imperative.path_count(10, 10)
  end

  x.report("snake case iterative") do
    SnakeCase::Iterative.path_count(10, 10)
  end

  x.report("snake case iterative 2") do
    SnakeCase::Iterative.path_count_2(10, 10)
  end

  x.report("snake case recursive") do
    SnakeCase::Recursive.path_count(10, 10)
  end

  x.report("snake case factorial") do
    SnakeCase::Factorial.path_count(10, 10)
  end

  x.report("snake case binary") do
    SnakeCase::Binary.path_count(10, 10)
  end

  x.compare! # Output the comparison
end
