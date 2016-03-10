require 'benchmark'

N = 100
def test_lazy(array)
  Benchmark.bm(10) do |r|
    r.report('Lazy:') do
      N.times do
        array.lazy.map { |x| x * 10 }.map { |x| x * 100 }.map { |x| x * 100 }.each { |x| x * 1000 }
      end
    end
    r.report('Normal:') do
      N.times do
        array.map { |x| x * 10 }.map { |x| x * 100 }.map { |x| x * 100 }.each { |x| x * 1000 }
      end
    end
  end
end

test_lazy([1,2,3]*1000)
