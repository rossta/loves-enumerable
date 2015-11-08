module CustomEnumerable
  def select
    ary = []
    each do |obj|
      ary << obj if yield(obj)
    end
    ary
  end
end

require_relative './custom_list'
class CustomList
  include CustomEnumerable
end

list = CustomList.new(1, 2, 3)

p list.select { |n| n < 3 }
# [1, 2]
