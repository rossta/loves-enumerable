require 'minitest/autorun'
require_relative './pascals_triangle'

class TestPascalsTriangle < Minitest::Test
  def setup
    @pascal = PascalsTriangle.new
  end

  def test_additional_rows_default
    rows = @pascal.rows
    assert_equal [1], rows.next
    assert_equal [1, 1], rows.next
    assert_equal [1, 2, 1], rows.next
    assert_equal [1, 3, 3, 1], rows.next
    assert_equal [1, 4, 6, 4, 1], rows.next
    assert_equal [1, 5, 10, 10, 5, 1], rows.next
  end

  def test_first_row_default
    assert_equal [1], @pascal.rows.first
  end

  def test_first_row_seeded
    assert_equal [1, 1], @pascal.rows([1,1]).first
  end

  def test_additional_rows_default
    rows = @pascal.rows
    assert_equal [1], rows.next
    assert_equal [1, 1], rows.next
    assert_equal [1, 2, 1], rows.next
    assert_equal [1, 3, 3, 1], rows.next
    assert_equal [1, 4, 6, 4, 1], rows.next
    assert_equal [1, 5, 10, 10, 5, 1], rows.next
  end

  def test_additional_rows_seeded
    rows = @pascal.rows([3])
    assert_equal [3], rows.next
    assert_equal [3, 3], rows.next
    assert_equal [3, 6, 3], rows.next
    assert_equal [3, 9, 9, 3], rows.next
    assert_equal [3, 12, 18, 12, 3], rows.next
    assert_equal [3, 15, 30, 30, 15, 3], rows.next
  end
end
