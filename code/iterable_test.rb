require 'minitest/autorun'
require './iterable'

class TestIterable < Minitest::Test
  include Iterable

  def test_increment
    sequence = iterate(1) { |x| x + 1 }

    assert_equal sequence.first(5), [1, 2, 3, 4, 5]
  end

  def test_decrement
    sequence = iterate(0) { |x| x - 1 }

    assert_equal sequence.first(5), [0, -1, -2, -3, -4]
  end
end
