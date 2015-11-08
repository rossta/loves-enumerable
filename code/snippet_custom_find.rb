module CustomEnumerable
  def find(ifnone = nil)
    each do |obj|
      return obj if yield(obj)
    end

    ifnone.call if ifnone
  end
end

require_relative './custom_list'
class CustomList
  include CustomEnumerable
end

list = CustomList.new(1, 2, 3)

p list.find { |n| n > 2 }
p list.find(-> { raise "Oops!" }) { |n| n > 3 } rescue puts $!.class

# 3
# RuntimeError
