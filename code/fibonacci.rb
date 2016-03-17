def fibonacci(limit)
  a, b, c = 0, 1, 0
  while c < limit do
    yield a
    a, b, c = b, a+b, c+1
  end
end

fibonacci(100) { |n| puts n }
