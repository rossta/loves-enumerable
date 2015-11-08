require "fiber"

class CustomEnumerator
  def initialize(target, iter)
    @target = target
    @iter   = iter
  end

  def each(&block)
    @target.send(@iter, &block)
  end

  def next
    @fiber ||= Fiber.new do
      each { |e| Fiber.yield(e) }

      raise StopIteration
    end

    if @fiber.alive?
      @fiber.resume
    else
      raise StopIteration
    end
  end

  def rewind
    @fiber = nil
  end

  def with_index
    i = 0
    each do |e|
      out = yield(e, i)
      i += 1
      out
    end
  end
end
