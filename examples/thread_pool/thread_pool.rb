class ThreadPool
  def initialize(size:)
    @pool = []
  end

  def schedule(*args, &block)
    @pool << Thread.new { block.call(args) }
  end

  def shutdown
    @pool.map(&:join)
  end
end
