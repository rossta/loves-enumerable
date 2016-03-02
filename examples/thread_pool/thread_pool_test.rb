require 'minitest/autorun'
require 'minitest/pride'
require_relative './thread_pool'

class TestThreadPool < Minitest::Test
  def test_basic_usage
    pool_size = 5
    pool = ThreadPool.new(size: pool_size)

    mutex = Mutex.new

    iterations = pool_size * 3
    results = Array.new(iterations)

    iterations.times do |i|
      pool.schedule do
        mutex.synchronize do
          results[i] = i + 1
        end
      end
    end
    pool.shutdown

    assert_equal((1.upto(pool_size * 3)).to_a, results)
  end
end
