module Iterable
  def iterate(arg = self, &block)
    Enumerator.new do |yielder|
      current = arg
      loop do
        yielder << current
        current = yield(current)
      end
    end
  end
end
