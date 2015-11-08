class PascalsTriangle
  def rows(first = [1])
    Enumerator.new do |yielder|
      current = first
      loop do
        yielder << current
        current = next_row(current)
      end
    end
  end

  def next_row(row)
    ([0] + row).zip(row + [0]).map { |a, b| a + b }
  end
end

if __FILE__ == $0
  pascal = PascalsTriangle.new

  require 'pp'
  pp pascal.rows.take(7)

  # [[1],
  #  [1, 1],
  #  [1, 2, 1],
  #  [1, 3, 3, 1],
  #  [1, 4, 6, 4, 1],
  #  [1, 5, 10, 10, 5, 1],
  #  [1, 6, 15, 20, 15, 6, 1]]
end
