# from practicingruby.com
require_relative "./custom_enumerable"

class SortedList
  include CustomEnumerable

  def initialize
    @data = []
  end

  def <<(new_element)
    @data << new_element
    @data.sort!

    self
  end

  def each
    if block_given?
      @data.each { |e| yield e }
    else
      CustomEnumerator.new(self, :each)
    end
  end
end
