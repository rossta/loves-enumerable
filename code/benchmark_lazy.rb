require "benchmark/ips"

def make_test(len)
  arr = [1] * len
  n = 1000
  Benchmark.ips do |r|
    r.report('Lazy enumerator') do
      n.times { arr.lazy.map { |x| x * 9 }.map { |x| x * 55 }.map { |x| x * 100 } }
    end

    r.report('Simple array') do
      n.times { arr.map { |x| x * 9 }.map { |x| x * 55 }.map{ |x| x * 100 } }
    end

    r.compare!
  end
end

make_test(1000)


def take_test(len)
  arr = [1] * len
  n = 1000
  Benchmark.ips do |r|
    r.report('Lazy enumerator') do
      n.times { arr.lazy.map { |x| x * 9 }.map { |x| x * 55 }.map { |x| x * 100 }.take(10) }
    end
    r.report('Simple array') do
      n.times { arr.map { |x| x * 9 }.map { |x| x * 55 }.map { |x| x * 100 }.take(10) }
    end

    r.compare!
  end
end

take_test(1000)
