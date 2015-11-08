module Quicksort
  extend self

  def nom(n)
    Enumerator.new do |y|
      loop { y.yield(rand(100_000_000)) }
    end.take(n)
  end

  def quicksort(seq)
    seq = [seq]
    Enumerator.new do |y|
      loop do
        smalls, *rest = seq
        pivot, *xs = smalls

        if pivot
          seq = [
            xs.select { |x| x < pivot },
            pivot,
            xs.reject { |x| x < pivot },
            *rest
          ]
        else
          sorted, *seq = *rest

          raise StopIteration unless sorted

          y.yield(sorted)
        end
      end
    end
  end

  def lazy_quicksort(seq)
    seq = [seq]
    Enumerator.new do |y|
      loop do
        smalls, *rest = seq
        pivot, *xs = smalls

        if pivot
          seq = [
            xs.select { |x| x < pivot },
            pivot,
            xs.lazy.reject { |x| x < pivot },
            *rest
          ]
        else
          sorted, *seq = *rest

          raise StopIteration unless sorted

          y.yield(sorted)
        end
      end
    end
  end
end

require 'benchmark/ips'

Benchmark.ips do |x|
  x.report("quicksort") {
    Quicksort.quicksort(Quicksort.nom(1000))
  }
  x.report("lazy quicksort") {
    Quicksort.lazy_quicksort(Quicksort.nom(1000))
  }
  x.compare!
end
