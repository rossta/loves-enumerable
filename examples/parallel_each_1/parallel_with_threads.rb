class ParallelWithThreads
  def initialize(enum)
    @enum = enum
  end

  def each(&block)
    @enum.each(&block)
  end

  def map(&block)
    size = @enum.size
    results = Array.new(size)
    each do |item|
      results << Thread.new { yield(item) }
    end
    results
  end

  class ThreadPool
    def initialize(max = 1)
      @max = max
      @queue = Queue.new
      @workers = []
    end

    def schedule(*args, &job)
      @jobs << [job, args]
      spawn_worker if @workers.size < @max
    end

    def shutdown

    end

    def spawn_worker
      Thread.new {

      }
    end
  end
end

module Enumerable
  def parallel(&block)
    ParallelWithThreads.new(self, &block)
  end
end
