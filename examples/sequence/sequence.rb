module Sequence
  def repeat(arg = self)
    Enumerator.new do |yielder|
      loop do
        yielder << arg
      end
    end
  end

  def repeatedly
    Enumerator.new do |yielder|
      loop do
        yielder << yield
      end
    end
  end

  def iterate(arg = self)
    Enumerator.new do |yielder|
      current = arg
      loop do
        yielder << current
        current = yield(current)
      end
    end
  end
end
