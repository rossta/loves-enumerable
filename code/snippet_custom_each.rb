class Array
  def each
    for i in 0..length-1
      yield self[i]
    end
    self
  end
end

[1, 2, 3].each { |n| puts "- #{n}"}

# - 1
# - 2
# - 3
