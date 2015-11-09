module CustomEnumerable
  def map
    return enum_for(:map) unless block_given?

    [].tap do |result|
      each do |item|
        result << yield(item)
      end
    end
  end
end

require_relative './custom_list'
class CustomList
  include CustomEnumerable
end

list = CustomList.new(1, 2, 3)

p list.map { |n| n * n }

# [1, 4, 9]
