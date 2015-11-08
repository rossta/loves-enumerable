require_relative "./custom_enumerable"

class CustomList
  include CustomEnumerable

  def initialize(*data)
    @data = data
  end

  def each
    @data.each { |e| yield e }
  end
end
