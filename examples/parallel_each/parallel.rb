require 'concurrent/atomics'
require 'concurrent/configuration'
require 'concurrent/executors'

class Parallel
  def initialize(enum, opts = {})
    @enum = enum
    @executor = Concurrent::Options.executor_from_options(opts) || Concurrent.global_io_executor
  end

  def each( &block)
    @enum.each(&block)
  end

  def map(&block)
    results  = Array.new(size)
    latch    = Concurrent::CountDownLatch.new(size)
    index    = Concurrent::AtomicFixnum.new(-1)

    each do |element|
      i = index.increment
      @executor.post { results[i] = yield(element); latch.count_down }
    end

    latch.wait

    results
  end

  def size
    @enum.size
  end
end

module Enumerable
  def parallel(opts = {})
    Parallel.new(self, opts)
  end
end
