require 'concurrent/atomics'
require 'concurrent/configuration'
require 'concurrent/executors'

class Parallel
  def initialize(enum, opts = {})
    @enum = enum
    @executor = Concurrent::Options.executor_from_options(opts) ||
      Concurrent.global_fast_executor
  end

  def each( &block)
    run_in_parallel(:each, &block)
  end

  def map(&block)
    run_in_parallel(:map, &block)
  end

  def all?(&block)
    run_in_parallel(:all?, &block)
  end

  def size
    @enum.size
  end

  def run_in_parallel(method)
    return @enum.send(method) unless block_given?

    results  = Array.new(size)
    latch    = Concurrent::CountDownLatch.new(size)
    index    = Concurrent::AtomicFixnum.new(-1)

    @enum.each do |element|
      i = index.increment
      @executor.post { results[i] = yield(element); latch.count_down }
    end

    latch.wait

    results.send(method) { |v| v }
  end
end

module Enumerable
  def parallel(opts = {})
    Parallel.new(self, opts)
  end
end
