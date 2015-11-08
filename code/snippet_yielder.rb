class Yielder
  def initialize(&block)
    @proc = block
  end

  # @proc is Proc.new { |*args| yield *args }
  # yield scope of Generator#each
  def yield(*args)
    @proc.call(*args)
  end
end
