# source: practicingruby
# see also: Fiber section of pickaxe book
require "fiber"

class CustomEnumerator
  def initialize(target, iter)
    @target = target
    @iter   = iter
    rewind
  end

  def each
    return custom_enum(:each) unless block_given?

    loop { yield self.next }
  end

  def next
    if @fiber.alive?
      @fiber.resume
    else
      raise StopIteration
    end
  end

  def rewind
    @fiber = create_fiber
  end

  def with_index
    return custom_enum(:with_index) unless block_given?

    i = 0
    enumerate do |e|
      out = yield(e, i)
      i += 1
      out
    end
  end

  private

  def create_fiber
    Fiber.new do
      enumerate { |e| Fiber.yield(e) }

      raise StopIteration
    end
  end

  def enumerate(&block)
    @target.send(@iter, &block)
  end

  def custon_enum(method)
    CustomEnumerator.new(@target, method)
  end
end
