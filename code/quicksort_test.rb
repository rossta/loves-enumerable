require 'minitest/autorun'
require 'rubygems'
require 'pry'
require_relative './quicksort'

class QuicksortTest < MiniTest::Test

  def test_sorts_the_array
    assert_equal [1, 12, 21, 29, 34, 37, 46, 74, 75, 78, 91, 93],
      Quicksort.quicksort([91, 75, 34, 12, 37, 74, 46, 1, 93, 21, 29, 78])
  end
end
