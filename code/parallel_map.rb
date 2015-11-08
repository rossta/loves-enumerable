require 'celluloid/current'

class Parallel
  include Enumerable

  def initialize(collection)
    @collection = collection
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    futures = @collection.map { |elem| Celluloid::Future.new(elem, &block) }
    futures.each(&:value)

    @collection
  end
end


collection = Parallel.new(1.upto(10))
puts collection.map { |n| puts n; sleep(rand 5); n * 2 }.join(', ')

# ruby
# $ be ruby parallel_map.rb
# 1
# 32
# 6
# 7
# 10
# 4
# 5
#
# 8
# 9
# 8, 20, 14, 6, 12, 4, 2, 10, 16, 18
