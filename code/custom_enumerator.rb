# source: practicingruby
# see also: Fiber section of pickaxe book
require "fiber"

class CustomEnumerator
  include Enumerable

  def initialize(target = nil, method = :each, &block)
    @target = if block_given?
                CustomGenerator.new(&block)
              else
                target
              end

    @method = method
  end

  def each
    return custom_enum(:each) unless block_given?

    loop { yield self.next }
  end

  def next
    if fiber.alive?
      fiber.resume
    else
      raise StopIteration
    end
  end

  def rewind
    @fiber = nil
  end

  def with_index
    return custom_enum(:with_index) unless block_given?

    i = 0
    @target.send(@method) do |e|
      out = yield(e, i)
      i += 1
      out
    end
  end

  private

  def fiber
    @fiber ||= Fiber.new do
      @target.send(@method) do |item|
        Fiber.yield(item)
      end

      raise StopIteration
    end
  end

  def custon_enum(method)
    CustomEnumerator.new(@target, method)
  end
end

class CustomGenerator
  include Enumerable

  def initialize(&block)
    @yielder = Fiber.new do
      yield Fiber
      raise StopIteration
    end
  end

  def each(&block)
    loop { yield self.next }
  end

  def next
    if @yielder.alive?
      @yielder.resume
    else
      raise StopIteration
    end
  end
end
