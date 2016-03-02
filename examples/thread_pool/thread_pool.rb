class ThreadPool
  def initialize(size:)
  end

  def schedule(*args, &block)
    block.call(args)
  end

  def shutdown
  end
end
