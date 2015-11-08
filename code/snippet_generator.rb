class Generator
  include Enumerable

  def initialize(&block)
    @proc = block
  end

  def each(*args)
    enclosed_yield = Proc.new { |*enclosed_args| yield *enclosed_args }

    @proc.call Yielder.new(&enclosed_yield), *args
  end
end

