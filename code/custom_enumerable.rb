# from practicingruby.com
require_relative "./custom_enumerator"

module CustomEnumerable
  def map
    return CustomEnumerator.new(self, :map) unless block_given?

    [].tap { |result| each { |e| result << yield(e) } }
  end

  def select
    [].tap { |result| each { |e| result << e if yield(e) } }
  end

  def find(ifnone = nil)
    each do |obj|
      return obj if yield(obj)
    end

    ifnone.call if ifnone
  end

  def reduce(arg = nil, &block)
    result = arg

    if !block_given?
      block = arg.to_proc
      result = nil
    end

    each do |e|
      if result.nil?
        result = e
      else
        result = block.call(result, e)
      end
    end

    result
  end

  def sort_by
    map { |e| [yield(e), e] }.sort.map { |a| a[1] }
  end
end

# My pass
#
# class CustomEnumerator
#   def initialize(obj, method)
#     @obj, @method = obj, method
#     @index = 0
#   end
#
#   def each(&block)
#     @obj.send(@method, &block)
#   end
#
#   def next
#     n = nil
#     i = 0
#     @obj.send(@method) do |e|
#       if @index == i
#         n = e
#         @index +=1
#         break
#       end
#       i += 1
#     end
#
#     n or fail StopIteration
#   end
#
#   def rewind
#     @index = 0
#   end
#
#   def with_index
#     i = 0
#     result = []
#     @obj.send(@method) do |e|
#       result << yield(e, i)
#       i += 1
#     end
#     result
#   end
# end

