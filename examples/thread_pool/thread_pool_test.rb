require 'minitest/autorun'
require 'minitest/pride'
require_relative './thread_pool'

class TestThreadPool < Minitest::Test
  def time_taken
    now = Time.now.to_f
    yield
    Time.now.to_f - now
  end

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

  def test_time_taken
    pool_size = 5
    pool = ThreadPool.new(size: pool_size)
    elapsed = time_taken do
      pool_size.times do
        pool.schedule { sleep 1 }
      end
      pool.shutdown
    end
    assert_operator 4.5, :>, elapsed,
      'Elased time was too long: %.1f seconds' % elapsed
  end

  def test_pool_size_limit
    pool_size = 5
    pool = ThreadPool.new(size: pool_size)
    mutex = Mutex.new
    threads = Set.new

    100_000.times do
      pool.schedule do
        mutex.synchronize do
          threads << Thread.current
        end
      end
    end
    pool.shutdown

    assert_equal(pool_size, threads.size)
  end
end
