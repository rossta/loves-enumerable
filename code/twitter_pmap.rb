module Twitter
  module Utils
    def pmap(enumerable)
      return to_enum(:pmap, enumerable) unless block_given?

      # Don't bother spawning a new thread if there's only one item
      if enumerable.count == 1
        enumerable.collect { |object| yield object }
      else
        enumerable.collect { |object| Thread.new { yield object } }.collect(&:value)
      end
    end
  end
end
