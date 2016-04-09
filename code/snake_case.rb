module SnakeCase
  module_function

  def paths(m, n)
    pascal.take(m+n)[-1][n]
  end

  def pascal(rows = [1])
    Enumerator.new do |y|
      loop { y.yield(rows = ([0] + rows).zip(rows + [0]).map { |a, b| a + b }) }
    end
  end
end
