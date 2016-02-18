require 'minitest/autorun'
require 'minitest/pride'
require_relative './sequence'

class TestSequence < Minitest::Test
  include Sequence

  class Sequenced < SimpleDelegator
    include Sequence
  end

  def test_repeat
    assert_equal repeat(3).take(5), [3, 3, 3, 3, 3]
  end

  def test_repeat_include
    num = Sequenced.new(3)

    assert_equal num.repeat(3).take(5), [3, 3, 3, 3, 3]
  end

  def test_repeatedly_number
    sequence = repeatedly { 2 }

    assert_equal sequence.first(5), [2, 2, 2, 2, 2]
  end

  def test_repeatedly_with_side_effects
    counter_class = Class.new do
      attr_reader :count

      def tick
        @count ||= 0
        @count += 1
      end
    end

    counter = counter_class.new

    sequence = repeatedly { counter.tick }

    assert_equal sequence.first(5), [1, 2, 3, 4, 5]
    assert_equal counter.count, 5
  end

  def test_iterate_increment
    sequence = iterate(1) { |x| x + 1 }

    assert_equal sequence.first(5), [1, 2, 3, 4, 5]
  end

  def test_iterate_decrement
    sequence = iterate(1) { |x| x * 2 }

    assert_equal sequence.first(5), [1, 2, 4, 8, 16]
  end

  def test_iterate_include
    num = Sequenced.new(0)

    sequence = num.iterate { |x| x - 1 }
    assert_equal sequence.first(5), [0, -1, -2, -3, -4]
  end
end
