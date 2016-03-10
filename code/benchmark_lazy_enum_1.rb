require 'benchmark'

def make_test len
  arr = [1] * len
  n = 1000
  Benchmark.bm(15) do |r|
    l = r.report('Lazy enumerator') do
      n.times { arr.lazy.map { |x| x * 9 }.map { |x| x * 55 }.each { |x| x * 100 } }
    end
    s = r.report('Simple array') do
      n.times { arr.map { |x| x * 9 }.map { |x| x * 55 }.each { |x| x * 100 } }
    end
    [s / l]
  end
end

make_test(1000)
