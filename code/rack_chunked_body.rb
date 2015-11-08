module Rack
  class Chunked
    class Body
      TERM = "\r\n"
      TAIL = "0#{TERM}#{TERM}"

      def initialize(body); @body = body; end

      def each
        term = TERM
        @body.each do |chunk|
          size = chunk.bytesize
          next if size == 0

          chunk = chunk.dup.force_encoding(Encoding::BINARY)
          yield [size.to_s(16), term, chunk, term].join
        end
        yield TAIL
      end
    end
  end
end
