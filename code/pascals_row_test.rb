require 'minitest/autorun'

def pascals_triangle(row = [1])
  current = row
  Enumerator.new do |y|
    loop do
      y << current
      current = pascals_row(current)
    end
  end
end

def pascals_row(row)
  ([0] + row).zip(row + [0]).collect { |a, b| a + b }
end

class TestPascalsTriangle < Minitest::Test
  def test_pascals_rows
    assert_equal [1, 1], pascals_row([1])
    assert_equal [1, 2, 1], pascals_row([1, 1])
    assert_equal [1, 3, 3, 1], pascals_row([1, 2, 1])
    assert_equal [1, 4, 6, 4, 1], pascals_row([1, 3, 3, 1])
    assert_equal [1, 5, 10, 10, 5, 1], pascals_row([1, 4, 6, 4, 1])
  end

  def test_pascals_triangle
    rows = pascals_triangle
    assert_equal [1], rows.next
    assert_equal [1, 1], rows.next
    assert_equal [1, 2, 1], rows.next
    assert_equal [1, 3, 3, 1], rows.next
    assert_equal [1, 4, 6, 4, 1], rows.next
    assert_equal [1, 5, 10, 10, 5, 1], rows.next
  end
end

pascals_triangle.with_index(1).take(10).each do |row, i|
  puts "%d:%#{20+(row.inspect.length/2)}s" % [i, row.inspect]
end
