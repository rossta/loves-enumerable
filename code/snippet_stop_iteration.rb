p [1, 2, 3].each
p [1, 2, 3].map
enumerator = [1, 2, 3].each

p enumerator.next
p enumerator.next
p enumerator.next

begin
  p enumerator.next
rescue StopIteration => e
  p "Halt!!! #{e.class}"
end

enumerator.rewind

loop do
  p enumerator.next
end

p "Done!!!"

# <Enumerator: [1, 2, 3]:each>
# <Enumerator: [1, 2, 3]:map>
# 1
# 2
# 3
# "Halt!!!"
# <StopIteration: iteration reached an end>
# 1
# 2
# 3
# "Done!!!"
