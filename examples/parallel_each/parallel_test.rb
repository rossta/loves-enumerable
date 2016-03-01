require 'minitest/autorun'
require 'minitest/pride'
require_relative './parallel'

module Enumerable
  def parallel
    Parallel.new(self)
  end
end

class TestParallel < Minitest::Test
  def time_taken
    t = Time.now.to_f
    yield
    Time.now.to_f - t
  end

  def test_map_result
    assert_equal [2, 4, 6, 8], [1, 2, 3, 4].parallel.map { |x| x * 2  }
  end

  def test_saves_time
    assert_operator 3.5, :> , time_taken { [1, 2, 3, 4].parallel.map { sleep 1 } }
  end
end
