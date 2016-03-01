require 'concurrent/atomics'
require 'concurrent/configuration'
require 'concurrent/executors'

class Parallel
  def initialize(enum)
    @enum = enum
  end

  def each(&block)
    @enum.each(&block)
  end

  def map(&block)
    size     = each.size
    results  = Array.new(size)
    latch    = Concurrent::CountDownLatch.new(size)
    index    = Concurrent::AtomicFixnum.new(-1)
    executor = Concurrent::FixedThreadPool.new(size)
    # executor = Concurrent.global_fast_executor

    each do |element|
      i = index.increment
      executor.post { results[i] = yield(element); latch.count_down }
    end

    latch.wait

    results
  end
end
