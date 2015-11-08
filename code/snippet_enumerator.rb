# from patshaughnessy.net
enum = Enumerator.new do |y|
  y.yield 1 # ----------|
  y.yield 2 # ----------|
end         #           |
            #           |
          p enum.map { |i| i * i }

p enum

enum = Enumerator.new do |y|
  y.yield 1 # <= y is a Yielder
  y.yield 2
end

[1, 4]
<Enumerator: #<Enumerator::Generator:0x007fd3228a47b8>:each>
