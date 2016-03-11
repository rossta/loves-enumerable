require 'minitest/autorun'
require 'minitest/pride'
require 'benchmark'
require_relative './parallel'

class TestParallel < Minitest::Test
  def time_taken
    yield
  end

  def test_map_result
    assert_equal [2, 4, 6, 8], [1, 2, 3, 4].parallel.map { |x| x * 2  }
  end

  def test_each_result
    count = 0
    [1, 2, 3, 4].parallel.each { |x| count += x  }
    assert_equal 10, count
  end

  def test_saves_time
    assert_operator 0.4, :> , time_taken { [1, 2, 3, 4].parallel.map { sleep 0.1 } }
  end
end
