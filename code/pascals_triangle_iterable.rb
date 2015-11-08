require_relative './iterable'

class PascalsTriangle
  include Iterable

  def rows(first = [1])
    iterate(first) do |row|
      ([0] + row).zip(row + [0]).map { |a, b| a + b }
    end
  end
end

if __FILE__ == $0
  pascal = PascalsTriangle.new

  p pascal.rows.take(7)
end
