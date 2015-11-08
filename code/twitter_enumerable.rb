# twitter gem
module Twitter
  module Enumerable
    include ::Enumerable

    def each(start = 0)
      return to_enum(:each, start) unless block_given?

      Array(@collection[start..-1]).each do |element|
        yield(element)
      end

      unless last?
        start = [@collection.size, start].max
        fetch_next_page # api call adds to @collection
        each(start, &Proc.new)
      end
      self
    end
  end
end
