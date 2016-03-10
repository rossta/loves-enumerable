require 'benchmark'
N = 1000
DATA_LENGTH = 1000
DATA = [1] * DATA_LENGTH

def bencher(lazy)
  Benchmark.bm(15) do |r|
    r.report(ARGV[0]) do
      N.times { lazy.each { |x| x * 100 } }
    end
  end
end

def puts_header(name)
  puts "======================Lazy##{name}"
end

puts_header("map")
bencher(DATA.lazy.map { |x| x * 9 }.map { |x| x * 55 })
puts_header("select")
bencher(DATA.lazy.select { |x| x > 0 }.select { |x| x > 0 })
puts_header("grep")
bencher(DATA.lazy.grep(proc { |x| x > 0 }).grep(proc { |x| x > 0 }))
puts_header("take_while")
bencher(DATA.lazy.take_while { |x| x > 0 }.take_while { |x| x > 0 })
puts_header("drop_while")
bencher(DATA.lazy.drop_while { |x| x < 0 }.drop_while { |x| x < 0 })
puts_header("reject")
bencher(DATA.lazy.reject { |x| x < 0 }.reject { |x| x < 0 })
puts_header("drop")
bencher((DATA * 4).lazy.drop(DATA_LENGTH * 2).drop(DATA_LENGTH))
puts_header("take")
bencher(DATA.lazy.take(DATA_LENGTH).take(DATA_LENGTH))
